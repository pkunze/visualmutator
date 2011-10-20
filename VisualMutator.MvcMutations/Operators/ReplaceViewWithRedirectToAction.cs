﻿namespace VisualMutator.MvcMutations
{
    #region Usings

    using System;
    using System.Collections.Generic;
    using System.ComponentModel.Composition;
    using System.Diagnostics;
    using System.Linq;
 
    using Mono.Cecil;
    using Mono.Cecil.Cil;
    using Mono.Cecil.Rocks;
    using VisualMutator.Extensibility;

    #endregion

    [Export(typeof(IMutationOperator))]
    public class ReplaceViewWithRedirectToAction : IMutationOperator
    {
     
        private class ThisMutationTarget : InstructionMutationTarget
        {
            public ThisMutationTarget(MethodDefinition method, int instrOffset, MethodDefinition toRedirect)
                : base(method, instrOffset)
            {
                MethodToRedirectToFullName = toRedirect.FullName;
            }

            public string MethodToRedirectToFullName
            {
                get; private set;
            }

        }

        public IEnumerable<MutationTarget> FindTargets(IEnumerable<TypeDefinition> types)
        {
            var list = new List<ThisMutationTarget>();
            var controllers = types.Where(t => t.IsOfType("System.Web.Mvc.Controller"));
 
            foreach (var controller in controllers)
            {
                var methodsToModify = controller.Methods
                  .Where(m =>
                      !m.IsAbstract &&
                      m.ReturnType.FullName == "System.Web.Mvc.ActionResult");

             
                foreach (var methodToModify in methodsToModify)
                {

                    MethodDefinition methodToRedirectTo = controller.Methods
                    .FirstOrDefault(m =>
                        m != methodToModify
                        && m.IsPublic
                        && m.Parameters.Count == 0
                        && m.ReturnType.FullName == ("System.Web.Mvc.ActionResult"));

                    if (methodToRedirectTo != null)
                    {
                        list.AddRange(FindValidViewCallInstructions(methodToModify, methodToRedirectTo));
                    }
                }
            }
            
            return list;
        }

        private IEnumerable<ThisMutationTarget> FindValidViewCallInstructions(MethodDefinition methodToModify, 
            MethodDefinition methodToRedirectTo)
        {
    
            var a = from _ in methodToModify.Body.Instructions.Select((instruction, index)=> new {instruction, index})
            where _.instruction.OpCode == OpCodes.Call
            let method = ((MethodReference)_.instruction.Operand)
            where method.DeclaringType.FullName == "System.Web.Mvc.Controller"
                  && method.Name == "View" && HasProperParameters(methodToModify, _.instruction, method )
                    select new ThisMutationTarget(methodToModify, _.index, methodToRedirectTo);
            return a;
        }

        public MutationResultsCollection CreateMutants(IEnumerable<MutationTarget> targets, 
            AssembliesToMutateFactory assembliesFactory)
        {
            var results = new MutationResultsCollection();

            foreach (ThisMutationTarget target in targets.Cast<ThisMutationTarget>())
            {

                var assemblies = assembliesFactory.GetNewCopy();
                var methodToModify = target.GetMethod(assemblies);
                var methodToRedirectTo = methodToModify.DeclaringType.Methods
                    .Single(m => m.FullName == target.MethodToRedirectToFullName);

                methodToModify.Body.SimplifyMacros();

                if (target.InstructionOffset == 209)
                {
                    Debug.WriteLine("##############");
                    Debug.WriteLine("##############");
                    Debug.WriteLine("##############");
                    foreach (var instruction in methodToModify.Body.Instructions)
                    {
                        Debug.WriteLine(instruction);
                    }
                }
              //  var callInstr = methodToModify.Body.GetInstructionAtOffset(target.InstructionOffset);
                var callInstr = methodToModify.Body.Instructions[target.InstructionOffset];
                

                MethodDefinition redirectToActionMethod = GetRedirectToActionMethod(methodToModify.DeclaringType.Module);


                ILProcessor proc = methodToModify.Body.GetILProcessor();
                var method = (MethodReference)callInstr.Operand;



                foreach (var _ in method.Parameters)
                {
                    proc.Remove(callInstr.Previous);
                }

                proc.InsertBefore(callInstr, Instruction.Create(OpCodes.Ldstr, methodToRedirectTo.Name));


                proc.Replace(callInstr, Instruction.Create(OpCodes.Call, 
                    methodToModify.DeclaringType.Module.Import(redirectToActionMethod)));

                var result = new MutationResult
                {
                    MutatedAssemblies = assemblies,
                    MutationTarget = target
                };

                results.MutationResults.Add(result);

                methodToModify.Body.OptimizeMacros();
            }


            return results;


        }


        /*
        public MutationResultDetails Mutate(ModuleDefinition module, IEnumerable<TypeDefinition> types)
        {
             var controllers = types.Where(t => t.IsOfType("System.Web.Mvc.Controller"));
             MethodDefinition me = GetRedirectToActionMethod(module);
             IEnumerable<ThisMutationTarget> mutationTargets = controllers.SelectMany(GetMutationTargets).ToList();
             foreach (ThisMutationTarget target in mutationTargets)
            {
       
                var callInstr = target.InstructionToReplace;

                ILProcessor proc = target.MethodToModify.Body.GetILProcessor();
                var method = (MethodReference)callInstr.Operand;

                
           
                foreach (var t in method.Parameters)
                {
                    proc.Remove(callInstr.Previous);
                }

                proc.InsertBefore(callInstr, Instruction.Create(OpCodes.Ldstr, target.MethodToRedirectTo.Name));
                proc.Replace(callInstr, Instruction.Create(OpCodes.Call, module.Import(me)));
            }

            var result = new MutationResultDetails
            {
               
                ModifiedMethods = mutationTargets.Select(t=> t.MethodToModify.FullName).ToList(),
            };

            return result;

        }
       

        private IEnumerable<ThisMutationTarget> GetMutationTargets(TypeDefinition controller)
        {
            var methodsToModify = controller.Methods
                   .Where(m =>
                       !m.IsAbstract &&
                       m.ReturnType.FullName == "System.Web.Mvc.ActionResult");

            var list = new List<ThisMutationTarget>();

            foreach (var methodToModify in methodsToModify)
            {
                
                MethodDefinition methodToRedirectTo = controller.Methods
                .FirstOrDefault(m =>
                    m != methodToModify
                    && m.IsPublic
                    && m.Parameters.Count == 0
                    && m.ReturnType.FullName==("System.Web.Mvc.ActionResult"));

                if (methodToRedirectTo != null)
                {
                    foreach (var instr in FindValidViewCallInstruction(methodToModify))
                    {
                        var target = new ThisMutationTarget
                        {
                            MethodFullName = methodToModify.FullName,
                            MethodToRedirectToFullName = methodToRedirectTo.FullName,
                            InstructionOffset = instr.Offset
                        };
                        list.Add(target);
                    }
                }
            }

            return list;

        }
         */

        public MethodDefinition  GetRedirectToActionMethod(ModuleDefinition currentModule)
        {
            var mvcModule = CecilExtensions.GetAspNetMvcModule(currentModule);


            return mvcModule.Types.Single(t => t.FullName == "System.Web.Mvc.Controller")
                    .Methods.Single(m => m.FullName ==
        "System.Web.Mvc.RedirectToRouteResult System.Web.Mvc.Controller::RedirectToAction(System.String)");     
        }



        public string Name
        {
            get
            {
                return "Replace method return statement.";
            }
        }

        public string Description
        {
            get
            {
                return "Replaces previous ActionResult with RedirectToAction.";
            }
        }
        /*
        private static IEnumerable<Instruction> FindValidViewCallInstructions(MethodDefinition methodToModify)
        {
            int i = 0;
            foreach (var instr in methodToModify.Body.Instructions)
            {
                if (instr.OpCode == OpCodes.Call)
                {
                    var method = ((MethodReference)instr.Operand);
                    if (method.DeclaringType.FullName == "System.Web.Mvc.Controller"
                        && method.Name == "View" && HasProperParameters(methodToModify, instr, method))
                    {
                        var target = new ThisMutationTarget(methodToModify, instr)
                        {
                            MethodToRedirectToFullName = methodToRedirectTo.FullName,
                        };
                    }
                }
                i++;
            }
            methodToModify.Body.Instructions.Select((instruction, index)=> new {instruction, index})
                .Where( _ => _.instruction.OpCode == OpCodes.Call)

            var a = from _ in methodToModify.Body.Instructions.Select((instruction, index)=> new {instruction, index})
            where _.instruction.OpCode == OpCodes.Call
            let method = ((MethodReference)_.instruction.Operand)
            where method.DeclaringType.FullName == "System.Web.Mvc.Controller"
                  && method.Name == "View" && HasProperParameters(methodToModify, _.instruction, method )
            select _.instruction;
            return a;
        }
        */
        private static bool HasProperParameters(MethodDefinition methodToModify, Instruction callInstruction, MethodReference method )
        {
            methodToModify.Body.SimplifyMacros();

            if (callInstruction.Offset == 209)
            {
                Debug.WriteLine("##############");
                Debug.WriteLine("##############");
                Debug.WriteLine("##############");
                foreach (var instruction in methodToModify.Body.Instructions)
                {
                    Debug.WriteLine(instruction);
                }
            }


            Instruction currentInstr = callInstruction.Previous;

            var validOpcodes = new List<OpCode>
            {
                OpCodes.Ldstr,
                OpCodes.Ldloc,
                OpCodes.Ldarg,
                OpCodes.Ldnull,

            };

            var list = new List<Instruction>();
            foreach (var x in method.Parameters)
            {
                list.Add(currentInstr);
                currentInstr = currentInstr.Previous;
            }

            var sss = list.Select(i => i.OpCode).All(validOpcodes.Contains);

            methodToModify.Body.OptimizeMacros();
            return sss;

        }
    }

  
}