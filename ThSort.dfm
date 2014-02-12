object ThreadSortForm: TThreadSortForm
  Left = 132
  Top = 31
  BorderStyle = bsDialog
  Caption = 'Thread Sorting Demo'
  ClientHeight = 658
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 24
    Width = 177
    Height = 233
  end
  object Bevel3: TBevel
    Left = 376
    Top = 24
    Width = 177
    Height = 233
  end
  object Bevel2: TBevel
    Left = 192
    Top = 24
    Width = 177
    Height = 233
  end
  object BubbleSortBox: TPaintBox
    Left = 8
    Top = 24
    Width = 177
    Height = 233
    OnPaint = BubbleSortBoxPaint
  end
  object SelectionSortBox: TPaintBox
    Left = 192
    Top = 24
    Width = 177
    Height = 233
    OnPaint = SelectionSortBoxPaint
  end
  object QuickSortBox: TPaintBox
    Left = 376
    Top = 24
    Width = 177
    Height = 233
    OnPaint = QuickSortBoxPaint
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 55
    Height = 13
    Caption = 'Bubble Sort'
  end
  object Label2: TLabel
    Left = 192
    Top = 8
    Width = 66
    Height = 13
    Caption = 'Selection Sort'
  end
  object Label3: TLabel
    Left = 376
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Quick Sort'
  end
  object Bevel4: TBevel
    Left = 8
    Top = 296
    Width = 177
    Height = 233
  end
  object InsertBox: TPaintBox
    Left = 8
    Top = 296
    Width = 177
    Height = 233
    OnPaint = InsertBoxPaint
  end
  object Label4: TLabel
    Left = 8
    Top = 278
    Width = 48
    Height = 13
    Caption = 'Insert Sort'
  end
  object Bevel5: TBevel
    Left = 192
    Top = 296
    Width = 177
    Height = 233
  end
  object MergeBox: TPaintBox
    Left = 192
    Top = 296
    Width = 177
    Height = 233
    OnPaint = MergeBoxPaint
  end
  object Label5: TLabel
    Left = 192
    Top = 278
    Width = 52
    Height = 13
    Caption = 'Merge Sort'
  end
  object Bevel6: TBevel
    Left = 376
    Top = 296
    Width = 177
    Height = 233
  end
  object HeapBox: TPaintBox
    Left = 376
    Top = 296
    Width = 177
    Height = 233
    OnPaint = HeapBoxPaint
  end
  object Label6: TLabel
    Left = 376
    Top = 278
    Width = 48
    Height = 13
    Caption = 'Heap Sort'
  end
  object Label7: TLabel
    Left = 8
    Top = 553
    Width = 442
    Height = 40
    Caption = #20132#25442#25490#24207#21306#65306#28176#36817#19978#38480'~O(nlgn)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -32
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 608
    Top = 497
    Width = 224
    Height = 80
    Caption = #38750#20132#25442#25490#24207#21306#65306#13#10#28176#36817#19978#38480'~O(n)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -32
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
  end
  object Bevel7: TBevel
    Left = 608
    Top = 24
    Width = 177
    Height = 233
  end
  object CountingBox: TPaintBox
    Left = 608
    Top = 24
    Width = 177
    Height = 233
    OnPaint = CountingBoxPaint
  end
  object Label9: TLabel
    Left = 608
    Top = 8
    Width = 64
    Height = 13
    Caption = 'Counting Sort'
  end
  object StartBtn: TButton
    Left = 8
    Top = 608
    Width = 817
    Height = 41
    Caption = 'Start Sorting'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = StartBtnClick
  end
  object Panel1: TPanel
    Left = 568
    Top = 0
    Width = 25
    Height = 593
    Color = clMaroon
    TabOrder = 1
  end
end
