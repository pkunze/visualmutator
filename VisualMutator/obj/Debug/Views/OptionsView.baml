   M S B A M L   `   `   `  ����H  DVisualMutator, Version=2.0.8.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:VisualMutator.ViewModelsVisualMutator.ViewModels  5   	   %    VisualMutator.Views.OptionsView   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   =
ViewModels&clr-namespace:VisualMutator.ViewModels     5   	   X TXceed.Wpf.Toolkit, Version=2.0.0.0, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  5   	     � Title$"  Options for Mutation Testing��5	   2   $	��360��5
   	   $	��275��6    � 	Resources 5       �� MergedDictionaries �� Source �� 
TargetType   
checkstyle �� Property �� Value�� 5   
    5      �� 5      $ Resources/Global.xaml?�6%   %�   &	        �� 5      " ��6   .�5      ��  � ��$ Center=�66   �� 5       � ��$ 25��6+   �� 5       � ��$ 3,0,3,0q�6+   5      5      .��5      �  � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $��25 �6   �� 5      $��25 �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5       $
��Auto �6   �� 5!      �� 5"      $
��Auto �6    � ColumnDefinitions 5$   
   �� 5%      $
��Auto �6   �� 5&      �� 5'      $
��Auto �6   .+�5*   
   � $��0��6   5,      � 5-   
   $��2��6    5.      �� 5/      $
��Auto �6#   �� 50      52      �� 59   
   $��5��6   $��0��6!   $&�� Source files processing threads:��61   %  Xceed.Wpf.Toolkit.IntegerUpDown  5:   
   $��5��6   $��1��6*   �  �Xceed.Wpf.Toolkit.NumericUpDown`1[[System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]	   Maximum$	 16X�6:   
   Minimum$
 0X�6G   �  �Xceed.Wpf.Toolkit.Primitives.UpDownBase`1[[System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]   Value 5;   #   �� * Options.WhiteCacheThreadsCount+ �� Mode$ TwoWay=��� 5<   
   $��6��6   $��0��6!   $ ��Mutant processing threads:��61     5=   
   $��6��6   $��1��6*   $	 16X�6:   $
 1X�6G    5>   #   �� * Options.ProcessingThreadsCount+$ TwoWay=��� 5?   
   $��3��6   #��[  6    $!��Use Code Coverage Detection��5@       d� 	IsChecked 5A      �� *Options.UseCodeCoverage+�� 5C   
   $��4��6   #��[  6    $��Enable mutant code cache��5D       5E      �� *Options.MutantsCacheEnabled+�� 5G   
   $��0��6   $��0��6!   $)��#Max number of mutants per operator:��61     5I   
   $��0��6   $��1��6*   $
	 1000X�6:   $
 1X�6I    5J   #   �� *%#Options.MaxNumerOfMutantPerOperator+$ TwoWay=��� 5K   
   $��1��6   $��0��6!   $3��-Time after which timed-out mutant is killed: ��61     5M   
   $��1��6   $��1��6*   $		 100X�6:   $
 1X�6H    5N   #   �� * Options.TimeFactorForMutations+$ TwoWay=��� 5P   
   $��2��6   $��0��6!   $��Mutation order: ��61     5R   
   $��2��6   $��1��6*   $	 2X�6:   $
 1X�6F    5S   #   �� *Options.MutationOrder+$ TwoWay=��� 5V   
   $��7��6   $��0��6!   $��Other Params:��61   �� 5W   
   $��8��6   $��2��6   ��63   �� *Options.OtherParams+$ TwoWay=�6g   ]� 5Y   
   $��9��6   $��Right=�6!   $��2��6=   .+�5Z      �� $��OK��6   ��6"   �� *CommandSave+�� 5[      $��Cancel��6   ��6&   �� *CommandClose+5\      5^      5_      