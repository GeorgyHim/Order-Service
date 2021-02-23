unit utils;

interface
uses System.SysUtils, System.JSON, System.Win.ScktComp, Vcl.Forms;

function getJsonStringAttribute(jsonObject: TJSONObject; key: String): String;
function getSocketString(inputByteArray: array of byte): String;
function createSocketForMobile(): TServerSocket;

implementation
function getJsonStringAttribute(jsonObject: TJSONObject; key: String): String;
begin
  result := jsonObject.GetValue(key).ToString;
  result := Copy(result, 2, result.Length - 2);
end;

function getSocketString(inputByteArray: array of byte): String;
var
  i: integer;
  receivedString: String;
begin
  for i := 0 to 4095 do
    begin
      receivedString := receivedString + TEncoding.ASCII.GetChars(inputByteArray[i])[0];
      if (Chr(inputByteArray[i]) = '}') and (Chr(inputByteArray[i-1]) = '"') then
        begin
          break;
        end;
    end;

  getSocketString := receivedString;
end;

function createSocketForMobile(): TServerSocket;
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

  createSocketForMobile := socket;
end;

end.
