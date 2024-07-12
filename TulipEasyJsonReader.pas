{ ******************************************************* }
{                                                         }
{               TULIP EASY JSON READER                    }
{                                                         }
{                  SAMER ASSIL - 2024                     }
{                                                         }
{ ******************************************************* }

unit TulipEasyJsonReader;

/// IMPORTANT
/// ALL KEYS IN THE JSON MUST BE IN CAPITAL CASE AND HAS NO SPACES
///
/// to use it:
/// 1. create TjsonValue object.
/// 2. use property "jdata" to access the json fields.
///
/// To get elements from array , just pass the index as parameter.
///

interface

uses
  System.JSON,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Generics.Collections;

type

  TJsonValueHelper = class helper for TJsonValue
  private
    function GetjData: Variant;
  public
    property jdata: Variant read GetjData;
  end;

  TVarJsonValueType = class(TInvokeableVariantType)
  protected
    function FixupIdent(const AText: string): string; override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean); override;
    function DoFunction(var Dest: TVarData; const V: TVarData; const Name: string; const Arguments: TVarDataArray): Boolean; override;
  end;

{$A16}

type
  TVarJsonValueData = record
    VType: TVarType;
    Reserved1, Reserved2, Reserved3: Word;
    JVal: TJsonValue;
    Reserved4: LongWord;
  end;

var
  VarJsonValueType: TVarJsonValueType = nil;

implementation

{ TVarJsonStringType }

procedure TVarJsonValueType.Clear(var V: TVarData);
begin
  inherited;
  SimplisticClear(V);
end;

procedure TVarJsonValueType.Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean);
begin
  inherited;
  SimplisticCopy(Dest, Source, Indirect);
end;

function TVarJsonValueType.DoFunction(var Dest: TVarData; const V: TVarData; const Name: string; const Arguments: TVarDataArray): Boolean;
var
  jv: TJsonValue;
  lv: TJsonValue;
begin
  try
    Result := true;
    jv := TVarJsonValueData(V).JVal.FindValue(Name);

    if not Assigned(jv) then
      raise Exception.Create(format('"%s" not found', [Name]));

    if length(Arguments) > 0 then
    begin
      lv := TJsonArray(jv).items[Arguments[0].VInteger];
      if not Assigned(lv) then
        raise Exception.Create(format('"%s" not found', [Name]));
      if (lv is TJsonString) or (lv is TJsonNumber) or (lv is TJSONBool) or (lv is TJSONNull) then
      begin
        Variant(Dest) := lv.Value;
        exit;
      end;

      if (lv is TJsonArray) or (lv is TJSONObject) then
      begin
        Variant(Dest) := lv.jdata;
        exit;
      end;
    end
    else
    begin
      if (jv is TJsonString) or (jv is TJsonNumber) or (jv is TJSONBool) or (jv is TJSONNull) then
      begin
        Variant(Dest) := jv.Value;
        exit;
      end;

      if (jv is TJsonArray) or (jv is TJSONObject) then
      begin
        Variant(Dest) := jv.jdata;
        exit;
      end;
    end;

  except
    on E: Exception do
    begin
      Result := false;
      raise Exception.Create(E.Message);
    end;
  end;

end;

function TVarJsonValueType.FixupIdent(const AText: string): string;
begin
  Result := AText;
  Result := ReplaceText(Result, '__', ' ');
end;

{ TJsonValueHelper }

function TJsonValueHelper.GetjData: Variant;
begin
  try
    VarClear(Result);
    TVarJsonValueData(Result).VType := VarJsonValueType.VarType;
    TVarJsonValueData(Result).JVal := Self;
  except
    On E: Exception do
      raise Exception.Create('[TulipJsonParse] ' + E.Message);
  end;

end;

initialization

{ Create our custom variant type, which will be registered automatically. }
VarJsonValueType := TVarJsonValueType.Create;

finalization

{ Free our custom variant type. }
FreeAndNil(VarJsonValueType);

end.
