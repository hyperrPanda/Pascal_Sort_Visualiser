program GameMain;
uses SwinGame,sgTypes,sgUserInterface,sysutils;

var
SortFlag: Integer;


procedure PopulateArray(var NumberArray: array of Integer);
var
i: Integer;
begin
for i:= low(NumberArray) to high(NumberArray) do
begin
NumberArray[i] := Rnd(ScreenHeight());
end;
end;

procedure ShowNumbersInList(var NumberArray: array of Integer);
var
i: Integer;
begin
ListClearItems('NumbersList');
for i:= low(NumberArray) to high(NumberArray) do
begin
ListAddItem('NumbersList', IntToStr(NumberArray[i]));
end;
end;

procedure PlotBars(var NumberArray: array of Integer);
var
i: Integer;
barwidth: LongInt;
begin
barwidth := ScreenWidth()-PanelWidth('NumberPanel');
barwidth := Round((barwidth/20));
for i:= low(NumberArray) to high(NumberArray) do
begin
FillRectangle(ColorRed,0+(barwidth*i),590,barwidth,-NumberArray[i]);
DrawInterface();
RefreshScreen ();
end;

end;

procedure Swap(var num1: Integer; var num2: Integer);
var
tmpnumber: Integer;
begin
tmpnumber := num1;
num1 := num2;
num2 := tmpnumber;
end;

procedure SelectionSort(var tmpArray: array of Integer);
var
i,j,min,n: Integer;
begin
i:= 0;
n := Length(tmpArray);
for i := 0 to n-1 do
begin
min := i;
for j := i+1 to n do
begin
if tmpArray[j] < tmpArray[min] then
begin
  min := j;
  Swap(tmpArray[min],tmpArray[i]);
  PlotBars(tmpArray);
  Delay(100);
end;
end;
end;
SortFlag := 0;
end;



procedure BubbleSort(var tmpArray: array of Integer);
var
i,j,n,tmpnumber: Integer;

begin
n := Length(tmpArray);

for i := 0 to n do
begin
for j := 0 to n-1-i do
begin
if(tmpArray[j]>tmpArray[j+1]) then
begin
Swap(tmpArray[j],tmpArray[j+1]);
PlotBars(tmpArray);
Delay(100);
end;
end;
end;
end;


procedure DoSort();
var
TempArray: array[0..19] of Integer;
begin
PopulateArray(TempArray);
ShowNumbersInList(TempArray);
PlotBars(TempArray);
if (SortFlag = 0) then
BubbleSort(TempArray)
else
SelectionSort(TempArray);
end;


procedure Main();


begin
SortFlag := 0;
  OpenGraphicsWindow('Hello World', 800, 600);

  LoadResourceBundle( 'NumberBundle.txt' );

  GUISetForegroundColor( ColorBlack );
  GUISetBackgroundColor( ColorWhite );

  ShowPanel( 'NumberPanel' );

  ClearScreen(ColorWhite);

  Repeat
 ProcessEvents();
 if  RegionClickedId()  = 'SortButton'   then
 begin

     DoSort();
end
     else if  (RegionClickedId()  = 'SortButton2')   then
      begin
      SortFlag := 1;

         DoSort();
        end;


 UpdateInterface();
  DrawInterface();
RefreshScreen ( 60 );

 Until WindowCloseRequested()

end;

begin
Main();

end.
