unit RestClientConfig;

interface


uses
  RestClient,
  System.Classes,
  HttpConnection;

type
  TRestClientConfig = class
  private
    class var FLog: TStrings;
    class procedure OnError(ARestClient: TRestClient; AResource: TResource;
      AMethod: TRequestMethod; AHTTPError: EHTTPError; var ARetryMode:
      THTTPRetryMode);
    class procedure OnBeforeRequest(ARestClient: TRestClient; AResource: TResource;
      AMethod: TRequestMethod);
    class procedure OnResponse(ARestClient: TRestClient; ResponseCode: Integer;
      const ResponseContent: string);
  public
    class function Novo(ALog: TStrings): TRestClient;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  StringUtils,
  RestUtils;

class function TRestClientConfig.Novo(ALog: TStrings): TRestClient;
begin
  FLog := ALog;

  Result := TRestClient.Create(nil);
  try
    Result.ConnectionType := hctWinHttp;
    Result.OnError := OnError;
    Result.OnBeforeRequest := OnBeforeRequest;
    Result.OnResponse := OnResponse;
    Result.Timeout.ConnectTimeout := 60000;
    Result.Timeout.SendTimeout := 300000;
    Result.Timeout.ReceiveTimeout := 300000;
  except
    Result.Free;
    raise
  end;
end;

class procedure TRestClientConfig.OnBeforeRequest(ARestClient: TRestClient;
  AResource: TResource; AMethod: TRequestMethod);
const
  RequestLog =
    '[RestClient] Request Method: %s' + sLineBreak +
    'URL: %s' + sLineBreak +
    'AcceptTypes: %s' + sLineBreak +
    'ContentTypes: %s' + sLineBreak +
    'AcceptedLanguages: %s' + sLineBreak +
    'Connect Timeout: %d' + sLineBreak +
    'Send Timeout: %d' + sLineBreak +
    'Receive Timeout: %d' + sLineBreak +
    'Proxy Credentials Informed: %s' + sLineBreak +
    'Async: %s' + sLineBreak +
    'Content: %s';
begin
  FLog.Add(Format(RequestLog, [GetEnumName(TypeInfo(TRequestMethod), Ord(AMethod)),
    AResource.GetURL,
    AResource.GetAcceptTypes,
    AResource.GetContentTypes,
    AResource.GetAcceptedLanguages,
    ARestClient.Timeout.ConnectTimeout,
    ARestClient.Timeout.SendTimeout,
    ARestClient.Timeout.ReceiveTimeout,
    BoolToStr(ARestClient.ProxyCredentials.Informed, True),
    BoolToStr(AResource.GetAsync, True),
    TStringUtils.StreamToString(AResource.GetContent)]));
end;

class procedure TRestClientConfig.OnError(ARestClient: TRestClient; AResource:
  TResource; AMethod: TRequestMethod; AHTTPError: EHTTPError; var ARetryMode:
  THTTPRetryMode);
begin
  FLog.Add('ERRO: ' + IntToStr(AHTTPError.ErrorCode) + ': ' + AHTTPError.ErrorMessage + sLineBreak);
end;

class procedure TRestClientConfig.OnResponse(ARestClient: TRestClient;
  ResponseCode: Integer; const ResponseContent: string);
begin
  if ResponseCode in [TStatusCode.OK.StatusCode, TStatusCode.CREATED.StatusCode] then
    FLog.Add(ResponseContent + sLineBreak);
end;

end.
