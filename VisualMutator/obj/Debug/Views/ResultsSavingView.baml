   M S B A M L   `   `   `  ����H  DVisualMutator, Version=2.0.8.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:VisualMutator.ViewModelsVisualMutator.ViewModels  5   	   +    %VisualMutator.Views.ResultsSavingView   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   =
ViewModels&clr-namespace:VisualMutator.ViewModels     5   	     � Title$#  Save Mutation Testing Results��5   2   $	��500��5   	   $	��200��6    � 	Resources 5	       �� MergedDictionaries �� Source �� 
TargetType   
checkstyle �� Property �� Value�� 5
   
    5      �� 5      $ Resources/Global.xaml?�6%   %�   &	        �� 5      " ��6   .�5      ��  � ��$ Center=�66   �� 5       � ��$ 25��6+   �� 5       � ��$ 3,0,3,0q�6+   5      5      .��5      �  � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      �� 5      $
��Auto �6   .+�5    
   � $��0��6    � ColumnDefinitions 5!      �� 5"      $
��Auto �6#   �� 5#      �� 5$      $
��Auto �6#   .+�5&      �� $��0��6   $��Target file path:��6(   �� 5'      $��1��6   $��Stretch=�6B   ��6&   �� *
TargetPath+6B   �� 5(      $��2��6   $��	Browse...��6%   ��69   �� *CommandBrowse+5)      �� 5*   
   $��1��6   #��[  6    $C��=Include detailed test results for each mutant (might be slow)��5+      	 d� 	IsChecked	 5,      �� *IncludeDetailedTestResults+�� 5-   
   $��2��6   #��[  6    $F��@Include code difference listings for each mutant (might be slow)��5.      	 5/      �� *IncludeCodeDifferenceListings+� 51   
   $��3��6   
 � IsIndeterminate
 .  $��16��6;   $
��0, 4q�6G    � Value 6U   �� *
Progress+]� 53   
   $��4��6   $��Right=�6!   .+�54      �� $��Save results��6   ��6,   �� *CommandSaveResults+�� 55      $��Cancel��6   ��6&   �� *CommandClose+58      59      5:      