   M S B A M L   `   `   `  ���� H  DVisualMutator, Version=2.0.8.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:VisualMutator.ViewModelsVisualMutator.ViewModels  +    %VisualMutator.Views.ResultsSavingView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     =
ViewModels&clr-namespace:VisualMutator.ViewModels       � Title$#  Save Mutation Testing Results��$	��500��$	��200�� � 	Resources  �� MergedDictionaries �� Source �� 
TargetType   
checkstyle �� Property �� Value��  �� $ Resources/Global.xaml?�%b   &	        �� " ��.���  � ��$ Center=���  � ��$ 25����  � ��$ 3,0,3,0q�.���  � RowDefinitions �� $
��Auto ��� $
��Auto ��� $
��Auto ��� �� $
��Auto �.+�� $��0�� � ColumnDefinitions �� $
��Auto ��� �� $
��Auto �.+��� $��0��$��Target file path:���� $��1��$��Stretch=����� *
TargetPath+�� $��2��$��	Browse...������ *CommandBrowse+�� $��1��#��[  $C��=Include detailed test results for each mutant (might be slow)��	 d� 	IsChecked	 �� *IncludeDetailedTestResults+�� $��2��#��[  $F��@Include code difference listings for each mutant (might be slow)��	 �� *IncludeCodeDifferenceListings+� $��3��
 � IsIndeterminate
 .  $��16��$
��0, 4q� � Value �� *
Progress+]� $��4��$��Right=�.+��� $��Save results������ *CommandSaveResults+�� $��Cancel������ *CommandClose+