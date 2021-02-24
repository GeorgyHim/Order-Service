unit utils;

interface
uses System.SysUtils, System.JSON, System.Win.ScktComp, Vcl.Forms;

function getJsonStringAttribute(jsonObject: TJSONObject; key: String): String;
function getFreePort(): Integer;

implementation
function getJsonStringAttribute(jsonObject: TJSONObject; key: String): String;
begin
  result := jsonObject.GetValue(key).ToString;
  result := Copy(result, 2, result.Length - 2);
end;

function getFreePort(): Integer;
var socket: TServerSocket;
flag: Boolean;
port: Integer;
begin
  socket := TServerSocket.Create(Application);
  socket.Active := False;

  flag := True;
  port := 7001;

  while flag and (port < 15000) do
  begin
    try
      socket.Active := False;
      socket.Port := port;
      socket.Active := True;
      flag := False;
    except
      inc(port);
    end;
  end;

  socket.Active := False;
  socket.Close;
  socket.Free;
  getFreePort := port;
end;

end.
