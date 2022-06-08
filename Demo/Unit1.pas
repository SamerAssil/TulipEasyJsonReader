unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.JSON,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, TulipEasyJsonReader;

type
  &Type = String;

  TForm1 = class( TForm )
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure FormDestroy( Sender: TObject );
    procedure Button2Click( Sender: TObject );
    procedure Button3Click( Sender: TObject );
    procedure Button4Click( Sender: TObject );
    procedure Button6Click( Sender: TObject );
    procedure Button7Click( Sender: TObject );
    procedure Button8Click( Sender: TObject );
    procedure Button9Click( Sender: TObject );
    procedure Memo1Exit( Sender: TObject );
    procedure Button5Click(Sender: TObject);
  private
    jval: TJsonValue;
    procedure LoadJsonFromMemo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.Button1Click( Sender: TObject );
begin
  Edit1.Text := jval.data.Lang(1);
end;

procedure TForm1.Button2Click( Sender: TObject );
begin
  Edit1.Text := jval.data.Lang(2);
end;

procedure TForm1.Button3Click( Sender: TObject );
begin
  // for space use two underscores instead
  Edit1.Text := jval.data.First__Name;
end;

procedure TForm1.Button4Click( Sender: TObject );
begin
  // as String
  Edit1.Text := jval.data.AGE;

  // as number
  var
    age: integer;
  age := jval.data.AGE;

  //Edit1.Text := AGE.ToString;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit1.Text := jval.data.Address.City;
end;

procedure TForm1.Button6Click( Sender: TObject );
begin
  Edit1.Text := jval.data.Address.Tel(0).Home;
end;

procedure TForm1.Button7Click( Sender: TObject );
begin
  Edit1.Text := jval.data.Address.Tel(1).Mobile;
end;

procedure TForm1.Button8Click( Sender: TObject );
begin
  Edit1.Text := jval.data.Address.Tel(1).EXT;
end;

procedure TForm1.Button9Click( Sender: TObject );
begin

  LoadJsonFromMemo;
end;

procedure TForm1.FormCreate( Sender: TObject );
begin
  LoadJsonFromMemo;
end;

procedure TForm1.FormDestroy( Sender: TObject );
begin
  jval.DisposeOf;
end;

procedure TForm1.LoadJsonFromMemo;
begin
  if Assigned( jval ) then
    jval.DisposeOf;
  jval := TJsonValue.ParseJSONValue( Memo1.Text );
end;

procedure TForm1.Memo1Exit( Sender: TObject );
begin
  LoadJsonFromMemo;
end;

end.
