unit SortThds;

interface

uses
  Classes, Graphics, ExtCtrls,windows,Sysutils;

type

{ TSortThread }

  PSortArray = ^TSortArray;
  TSortArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;

  TSortThread = class(TThread)
  private
    FBox: TPaintBox;
    FSortArray: PSortArray;
    FSize: Integer;
    FA, FB, FI, FJ: Integer;

    procedure DoVisualSwap;
    function GetTick:int64;
    procedure DoShowResult;
  protected
    procedure Execute; override;
    procedure VisualSwap(A, B, I, J: Integer);
    procedure Erease(i,len:integer);
    procedure Paint(i,len:integer);
    procedure Sort(var A: array of Integer); virtual; abstract;
  public
                                                                   s:string;
    constructor Create(Box: TPaintBox; var SortArray: array of Integer);

  end;

{ TBubbleSort }

  TBubbleSort = class(TSortThread)
  protected
    procedure Sort(var A: array of Integer); override;
  end;

{ TSelectionSort }

  TSelectionSort = class(TSortThread)
  protected
    procedure Sort(var A: array of Integer); override;
  end;

{ TQuickSort }

  TQuickSort = class(TSortThread)
  protected
    procedure Sort(var A: array of Integer); override;
  end;

  TInsertSort = class(TSortThread)
  protected
    procedure Sort(var A: array of Integer); override;
  end;

  TMergeSort = class(TSortThread)
  protected
    procedure Sort(var A: array of Integer); override;
  end;

  THeapSort = class(TSortThread)
  private
    heapSize:integer;
    function LeftChild(parent:integer):Integer;
    function RightChild(parent:integer):Integer;    
    procedure CreateMaxHeap(var A:array of Integer);
    procedure MaxHeapify(var A:array of Integer;i:integer);
    procedure Swap(var A:array of Integer;item1,item2:Integer);
  protected
    procedure Sort(var A: array of Integer); override;
  end;

  TCountingSort = class(TSortThread)
  protected
    procedure Sort(var A: array of Integer); override;
  end;


procedure PaintLine(Canvas: TCanvas; I, Len: Integer);

implementation

procedure PaintLine(Canvas: TCanvas; I, Len: Integer);
begin
  Canvas.PolyLine([Point(0, I * 2 + 1), Point(Len, I * 2 + 1)]);    //��϶
end;

{ TSortThread }

constructor TSortThread.Create(Box: TPaintBox; var SortArray: array of Integer);
begin
  FBox := Box;
  FSortArray := @SortArray;
  FSize := High(SortArray) - Low(SortArray) + 1;
  FreeOnTerminate := True;
  inherited Create(False);
end;

{ Since DoVisualSwap uses a VCL component (i.e., the TPaintBox) it should never
  be called directly by this thread.  DoVisualSwap should be called by passing
  it to the Synchronize method which causes DoVisualSwap to be executed by the
  main VCL thread, avoiding multi-thread conflicts. See VisualSwap for an
  example of calling Synchronize. }

procedure TSortThread.DoVisualSwap;
begin
  with FBox do
  begin
    Canvas.Pen.Color := clBtnFace;
    PaintLine(Canvas, FI, FA);
    PaintLine(Canvas, FJ, FB);
    Canvas.Pen.Color := clRed;
    PaintLine(Canvas, FI, FB);
    PaintLine(Canvas, FJ, FA);
  end;
end;

{ VisusalSwap is a wrapper on DoVisualSwap making it easier to use.  The
  parameters are copied to instance variables so they are accessable
  by the main VCL thread when it executes DoVisualSwap }

procedure TSortThread.VisualSwap(A, B, I, J: Integer);
begin
  FA := A;
  FB := B;
  FI := I;
  FJ := J;
  Synchronize(DoVisualSwap);
end;

{ The Execute method is called when the thread starts }

procedure TSortThread.Execute;
var
//  sbegin,send:integer;
    sbegin,send:int64;
begin
  sbegin:=GetTick;
  Sort(Slice(FSortArray^, FSize));
  send:=GetTick;
//  sbegin:=GetTickCount;
//  Sort(Slice(FSortArray^, FSize));
//  send:=GetTickCount;

  s:=IntToStr(send-sbegin) + ' ��CPU����';
  Synchronize(DoShowResult);
end;

procedure TSortThread.DoShowResult;
begin
  FBox.Canvas.TextOut(55,5,s);
end;

function TSortThread.GetTick: int64;
asm
  RDTSC;
end;


procedure TSortThread.Erease(i, len: integer);
begin
  with FBox do
  begin
    FBox.Canvas.Lock;
    Canvas.Pen.Color := clBtnFace;
    PaintLine(Canvas, i, len);
    FBox.Canvas.UnLock;    
  end;
end;

procedure TSortThread.Paint(i, len: integer);
begin
  with FBox do
  begin
    FBox.Canvas.Lock;
    Canvas.Pen.Color := clRed;
    PaintLine(Canvas, i, len);
    FBox.Canvas.UnLock;     
  end; 
end;

{ TBubbleSort }
//����˼�룺�����Ƚϣ�ֻҪ�Ǵ�������ƣ�С�ľ���ǰ��  ---  ����
procedure TBubbleSort.Sort(var A: array of Integer);
var
  I, J, T: Integer;
begin
  //�����һ������һ��      
  for I := High(A) downto Low(A) do
    //��һ�������һ�� ��һ��ѭ�����������Ǹ������ͳ���ײ�
    for J := Low(A) to High(A) - 1 do
      //��һ�����ڵڶ���������˳Ѱ
      if A[J] > A[J + 1] then
      begin
        VisualSwap(A[J], A[J + 1], J, J + 1);
        T := A[J];
        A[J] := A[J + 1];
        A[J + 1] := T;
        if Terminated then Exit;
      end;       
end;

{ TSelectionSort }
//����˼�룺ѡ����С�ķ��ڵ�һ������С�ķ��ڵڶ�������
procedure TSelectionSort.Sort(var A: array of Integer);
var
  I, J, T: Integer;
begin
  //����С�����
  for I := Low(A) to High(A) - 1 do
    //��ѭ�����������С
    for J := High(A) downto I + 1 do
      //ѡ��һ����С��Ԫ�ط��ڵ�һ��λ��
      if A[I] > A[J] then
      begin
        VisualSwap(A[I], A[J], I, J);
        T := A[I];
        A[I] := A[J];
        A[J] := T;
        if Terminated then Exit;
      end;
end;

{ TQuickSort }
//����˼�룺ѡ��һ����ŦԪ�أ�����Ŧ��ߵ�Ԫ�ض�ҪС����ŦԪ�أ��ұߵĶ�Ҫ������ŦԪ��
//��ʹ�õݹ��˼�룬�����ң��ߵ��ٴο�������
procedure TQuickSort.Sort(var A: array of Integer);

  procedure QuickSort(var A: array of Integer; iLo, iHi: Integer);
  var
    Lo, Hi, Mid, T: Integer;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2];   //������ŦԪ��
    repeat
      while A[Lo] < Mid do Inc(Lo);
      while A[Hi] > Mid do Dec(Hi);
      //�����ҽ���һ�ν���
      if Lo <= Hi then
      begin
        VisualSwap(A[Lo], A[Hi], Lo, Hi);
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    //������е�����ͱ�ʾ����Ѿ�ȫ����С���ұ���
    //�ڽ����ָ����������ٴν�������   
    if Hi > iLo then QuickSort(A, iLo, Hi);
    //�ڽ����ָ�������ұ��ٴν�������    
    if Lo < iHi then QuickSort(A, Lo, iHi);
    if Terminated then Exit;
  end;

begin
  QuickSort(A, Low(A), High(A));
end;

{ TInsertSort }
//����˼�룺���������Ϊ�������֣���һ������Ϊ�Ѿ���������飬�ڶ�������Ϊδ�������顣Ȼ�����δ�δ����������ѡ��һ�����ݲ��뵽�Ѿ����������
procedure TInsertSort.Sort(var A: array of Integer);
var
  i,j,t:Integer;
begin
  inherited;
  for i := 1 to Length(A)-1 do
  begin
    //A[0]�����Ѿ�������ֻ��1��Ԫ�ص�����
    t:=A[i];
    //ѡ�񲢲��� ������ͻ�����λ����
    j:=i-1;
    while ((j>=0) and (a[j]>t)) do
    begin
      Erease(j+1,a[j+1]);
      paint(j+1,a[j]);   //������Ҫͬ��
      a[j+1]:=a[j];
      Dec(j);
    end;
    Erease(j+1,a[j+1]);
    paint(j+1,t);
    A[j+1]:=t;
  end;   
end;

{ TMergeSort }

procedure TMergeSort.Sort(var A: array of Integer);
const
  VeryBig=999999999;  
  procedure Merge(var A:array of Integer;Left,Mid,Right:integer);
  var
    tempArray1,tempArray2:Array of Integer;
    count1,count2,i,j,k:integer;
  begin
    count1:=Mid-Left+1;
    count2:=Right-Mid; //����2�Ǵ�Mid+1��ʼ��
    SetLength(tempArray1,count1+1);
    SetLength(tempArray2,count2+1);
    for i := 0 to count1-1 do
    begin
      tempArray1[i]:=A[Left+i];
    end;
    for i := 0 to count2-1 do
    begin
      tempArray2[i]:=A[Mid+1+i];
    end;
    tempArray1[count1]:=VeryBig;
    tempArray2[count2]:=VeryBig;
    i:=0;
    j:=0;
    for k := Left to Right do
    begin
      if tempArray1[i]<=tempArray2[j] then
      begin
        Erease(k,a[k]);
        paint(k,tempArray1[i]);
        A[k]:= tempArray1[i];
        i:=i+1;
      end
      else
      begin
        Erease(k,a[k]);
        paint(k,tempArray2[j]);
        A[k]:= tempArray2[j];
        j:=j+1;
      end;
    end;
  end;
  procedure MergeSort(var A:array of Integer;left,right:integer);
  var
    Mid:integer;
  begin
    if left<right then
    begin
      Mid:=(left+right) div 2;
      MergeSort(A,left,Mid);
      MergeSort(A,Mid+1,right);
      Merge(A,left,Mid,right);
    end;
  end;
begin
  inherited;
  MergeSort(A,Low(A),High(A));
end;

{ THeapSort }

procedure THeapSort.CreateMaxHeap(var A: array of Integer);
var
  i:integer;
begin
  heapSize:=Length(A)-1;
  //������A[(length(A) div 2) +1 .. (length(A)-1] ����ȫ��������Ҷ�ӽڵ�
  for i := (heapSize shr 1) downto 0 do
  begin
    MaxHeapify(A,i);
  end;
end;

function THeapSort.LeftChild(parent: integer): Integer;
begin
  Result:=parent shl 1;
end;

function THeapSort.RightChild(parent: integer): Integer;
begin
  Result:=parent shl 1 +1;
end;

procedure THeapSort.MaxHeapify(var A: array of Integer; i: integer);
var
  Left,Right,bigger:Integer;
begin
  Left:= LeftChild(i);
  Right:= RightChild(i);
  //����Ҫȷ�����ڵ���벻С����������
  if (Left<=heapSize) then
  begin
    if (A[Left]>A[i]) then
      bigger := Left
    else
      bigger:= i;
  end;
  if (Right<=heapSize) then
    if (A[Right]>A[bigger]) then
      bigger:=Right;
  if bigger<>i then
  begin
    Swap(A,i,bigger);
    //�����ڵ�ֵ�ı�Ļ����ͼ����ݹ�����
    MaxHeapify(A,bigger);
  end;
end;

procedure THeapSort.Sort(var A: array of Integer);
var
  i:integer;
begin
  inherited;
  CreateMaxHeap(A);
  for i := heapSize downto 1 do
  begin
    Swap(A,i,0);
    Dec(heapSize);
    MaxHeapify(A,0);
  end;
end;

procedure THeapSort.Swap(var A:array of Integer;item1, item2: Integer);
var
  temp:integer;
begin
  VisualSwap(A[item1], A[item2], item1,item2);
  temp:=A[item1];
  A[item1]:=A[item2];
  A[item2]:=temp;
end;

{ TCountingSort }

procedure TCountingSort.Sort(var A: array of Integer);
var
  Max,i:Integer;
  B,C:Array of Integer;
  procedure CountingSort(var A,B,C:array of Integer);
  var
    i:integer;
  begin
    for i := 0 to Length(A)-1 do
    begin
      c[A[i]]:=c[A[i]]+1;  //c[i]��ʾ��Ī���ĸ���
    end;
    for i := 1 to Max do   //c[i]��ʾ��С�ڻ��ߵ���ĳ���ĸ���
    begin
      c[i]:=c[i]+c[i-1];
    end;
    for i := Length(A)-1 downto 0 do
    begin
      B[c[A[i]]-1]:=A[i];
      Dec(c[a[i]]);
    end;           
  end;
begin
  inherited;
  Max:=A[0];       //������Ҫȷ������Ԫ�ظ������ڻ��ߵ���1������rang out of boundary
  for i := 1 to Length(A)-1 do
  begin
    if a[I]>Max then Max:=A[i];
  end;
  SetLength(C,Max+1);//����0
  SetLength(B,Length(A));
  CountingSort(A,B,C);
  for i := 0 to Length(A)-1 do
  begin
    A[i]:=B[i];
  end;
  FBox.Invalidate;        
end;

end.