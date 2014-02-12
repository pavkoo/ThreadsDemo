unit ThSort;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TThreadSortForm = class(TForm)
    StartBtn: TButton;
    BubbleSortBox: TPaintBox;
    SelectionSortBox: TPaintBox;
    QuickSortBox: TPaintBox;
    InsertBox: TPaintBox;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel4: TBevel;
    Label4: TLabel;
    Bevel5: TBevel;
    MergeBox: TPaintBox;
    Label5: TLabel;
    Bevel6: TBevel;
    HeapBox: TPaintBox;
    Label6: TLabel;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel7: TBevel;
    CountingBox: TPaintBox;
    Label9: TLabel;
    procedure BubbleSortBoxPaint(Sender: TObject);
    procedure SelectionSortBoxPaint(Sender: TObject);
    procedure QuickSortBoxPaint(Sender: TObject);
    procedure InsertBoxPaint(Sender: TObject);
    procedure MergeBoxPaint(Sender: TObject);
    procedure HeapBoxPaint(Sender: TObject);
    procedure CountingBoxPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
  private
    ThreadsRunning: Integer;
    procedure RandomizeArrays;
    procedure ThreadDone(Sender: TObject);
  public
    procedure PaintArray(Box: TPaintBox; const A: array of Integer);
  end;

var
  ThreadSortForm: TThreadSortForm;

implementation

uses SortThds;

{$R *.dfm}

type
  PSortArray = ^TSortArray;
  TSortArray =  array[0..114] of Integer;  //114

var
  ArraysRandom: Boolean;
  BubbleSortArray, SelectionSortArray, QuickSortArray,
  InsertArray,MergeArray,HeapArray,CountingArray: TSortArray;

{ TThreadSortForm }

procedure TThreadSortForm.PaintArray(Box: TPaintBox; const A: array of Integer);
var
  I: Integer;
begin
  with Box do
  begin
    Canvas.Pen.Color := clRed;
    for I := Low(A) to High(A) do PaintLine(Canvas, I, A[I]);
  end;
end;

procedure TThreadSortForm.BubbleSortBoxPaint(Sender: TObject);
begin
  PaintArray(BubbleSortBox, BubbleSortArray);
end;

procedure TThreadSortForm.SelectionSortBoxPaint(Sender: TObject);
begin
  PaintArray(SelectionSortBox, SelectionSortArray);
end;

procedure TThreadSortForm.QuickSortBoxPaint(Sender: TObject);
begin
  PaintArray(QuickSortBox, QuickSortArray);
end;

procedure TThreadSortForm.InsertBoxPaint(Sender: TObject);
begin
  PaintArray(InsertBox, InsertArray);    
end;

procedure TThreadSortForm.MergeBoxPaint(Sender: TObject);
begin
  PaintArray(MergeBox, MergeArray);
end;


procedure TThreadSortForm.HeapBoxPaint(Sender: TObject);
begin
  PaintArray(HeapBox, HeapArray);
end;

procedure TThreadSortForm.CountingBoxPaint(Sender: TObject);
begin
  PaintArray(CountingBox, CountingArray);
end;


procedure TThreadSortForm.FormCreate(Sender: TObject);
begin
  RandomizeArrays;
end;

procedure TThreadSortForm.StartBtnClick(Sender: TObject);
begin
  RandomizeArrays;
  ThreadsRunning := 7;
  with TBubbleSort.Create(BubbleSortBox, BubbleSortArray) do
    OnTerminate := ThreadDone;
  with TSelectionSort.Create(SelectionSortBox, SelectionSortArray) do
    OnTerminate := ThreadDone;
  with TQuickSort.Create(QuickSortBox, QuickSortArray) do
    OnTerminate := ThreadDone;
  with TInsertSort.Create(InsertBox, InsertArray) do
    OnTerminate := ThreadDone;
  with TMergeSort.Create(MergeBox, MergeArray) do
    OnTerminate := ThreadDone;
  with THeapSort.Create(HeapBox, HeapArray) do
    OnTerminate := ThreadDone;
  with TCountingSort.Create(CountingBox, CountingArray) do
    OnTerminate := ThreadDone;
  StartBtn.Enabled := False;
end;

procedure TThreadSortForm.RandomizeArrays;
var
  I: Integer;
begin
  if not ArraysRandom then
  begin
    Randomize;
    for I := Low(BubbleSortArray) to High(BubbleSortArray) do
      BubbleSortArray[I] := Random(BubbleSortBox.Width-2);   //2是左右边框各留出的1px
    SelectionSortArray := BubbleSortArray;
    QuickSortArray := BubbleSortArray;
    InsertArray := BubbleSortArray;
    MergeArray := BubbleSortArray;
    HeapArray := BubbleSortArray;
    CountingArray := BubbleSortArray;
    ArraysRandom := True;
    Repaint;
  end;
end;

procedure TThreadSortForm.ThreadDone(Sender: TObject);
begin
  Dec(ThreadsRunning);
  if ThreadsRunning = 0 then
  begin
    StartBtn.Enabled := True;
    ArraysRandom := False;
  end;
end;



end.
