{*******************************************************}
{                                                       }
{               TULIP EASY JSON READER                  }
{                                                       }
{                 SAMER ASSIL - 2022                    }
{                                                       }
{*******************************************************}

unit TulipEasyJsonReader;


/// IMPORTANT
/// ALL KEYS IN THE JSON MUST BE IN CAPITAL CASE AND HAS NO SPACES
///
///  to use it:
///  1. create TjsonValue object.
///  2. use property "data" to access the json fields.
///
///  To get elements from array use the key word (elem) folowd by the index.
///  ex.  elem0, elem1, elem2....
///

interface


uses
  System.JSON, System.SysUtils, System.Variants, FMX.Dialogs;

type

  TJsonValueHelper = class helper for TJsonValue
  private
    function GetData: Variant;
  public
    property data: Variant read GetData;
  end;

  TVarJsonValueType = class( TInvokeableVariantType )
  public
    procedure Clear( var V: TVarData ); override;
    procedure Copy( var Dest: TVarData; const Source: TVarData; const Indirect: Boolean ); override;
    function GetProperty( var Dest: TVarData; const V: TVarData; const Name: string ): Boolean; override;
    function SetProperty( const V: TVarData; const Name: string; const Value: TVarData ): Boolean; override;
  end;

type
  TVarJsonValueData = packed record
    VType: TVarType;
    Reserved1, Reserved2, Reserved3: Word;
    JVal: TJsonValue;
    Reserved4: LongInt;
  end;

var
  VarJsonValueType: TVarJsonValueType = nil;

implementation


{ TVarJsonStringType }

procedure TVarJsonValueType.Clear( var V: TVarData );
begin
  inherited;
  SimplisticClear( V );
end;

procedure TVarJsonValueType.Copy( var Dest: TVarData; const Source: TVarData; const Indirect: Boolean );
begin
  inherited;
  SimplisticCopy( Dest, Source, Indirect );
end;

function TVarJsonValueType.GetProperty( var Dest: TVarData; const V: TVarData; const Name: string ): Boolean;
var
  jv: TJsonValue;
begin

    jv     := TVarJsonValueData( V ).JVal.FindValue( Name );
    result := Assigned( jv );

    if result then
    begin

      if ( jv is TJsonArray ) then
      begin
        Variant( Dest ) := jv.data;
        exit;
      end;

      if ( jv is TJsonString ) or ( jv is TJsonNumber ) then
      begin
        Variant( Dest ) := jv.Value;
        exit;
      end;

      if ( jv is TJsonValue ) or ( jv is TJsonValue ) then
      begin
        Variant( Dest ) := jv.data;
        exit;
      end;
    end
    else
      raise Exception.Create( format( '"%s" not found', [Name] ) );

end;

function TVarJsonValueType.SetProperty( const V: TVarData; const Name: string; const Value: TVarData ): Boolean;
begin

end;

{ TJsonValueHelper }

function TJsonValueHelper.GetData: Variant;
begin
  try
    var
      s: string := Self.ToJSON;
    if Self is TJsonArray then
    begin
      var
        j: tjsonobject;
      j := tjsonobject.Create;
      var
        item: TJsonValue;
      var
        i: integer := 0;

      for item in TJsonArray( Self ) do
      begin
        j.AddPair( UpperCase( 'elem' ) + i.tostring, item );
        inc( i );
      end;

      VarClear( result );
      TVarJsonValueData( result ).VType := VarJsonValueType.VarType;
      TVarJsonValueData( result ).JVal  := j as TJsonValue;
    end
    else
    begin
      VarClear( result );
      TVarJsonValueData( result ).VType := VarJsonValueType.VarType;
      TVarJsonValueData( result ).JVal  := Self;
    end;

  except
    On E: Exception do
      raise Exception.Create( '[TulipJsonParse] ' + E.Message );
  end;
  // result := VarJsonValueCreate( Self );
end;

initialization

{ Create our custom variant type, which will be registered automatically. }
VarJsonValueType := TVarJsonValueType.Create;

finalization

{ Free our custom variant type. }
FreeAndNil( VarJsonValueType );

end.
