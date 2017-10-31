unit StringUtils;

interface

uses
  System.Classes;

type
  TStringUtils = class
  public
    class function StreamToString(AStream: TStream): string;
  end;

implementation

class function TStringUtils.StreamToString(AStream: TStream): string;
var
  S: TStringStream;
begin
  S := TStringStream.Create;
  try
    S.LoadFromStream(AStream);
    Result := S.DataString;
  finally
    S.Free;
  end;
end;

end.
