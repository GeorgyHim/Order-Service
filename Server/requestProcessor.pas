unit requestProcessor;

  interface
uses
  System.SysUtils, System.Variants, System.Classes,
  System.Win.ScktComp, System.JSON, mydm, utils;

// ---CLIENT---
procedure login(receivedJson:TJSONObject; Socket: TCustomWinSocket);
procedure create_admin_user(receivedJson: TJSONObject);
procedure create_operator(receivedJson: TJSONObject);



implementation

  // ---CLIENT---
procedure login(receivedJson:TJSONObject; Socket: TCustomWinSocket);
var
  username, password: String;
  user_id: Int64;
  role: SmallInt;
  success: Boolean;
  jsonToSend: TJSONObject;
begin
  username := getJsonStringAttribute(receivedJson, 'username');
  password := getJsonStringAttribute(receivedJson, 'password');
  success:= dm.CheckPassword(username, password, user_id, role);

  jsonToSend := TJSONObject.Create;
  jsonToSend.AddPair('operation', 'client_login');
  jsonToSend.AddPair('success', TJSONBool.Create(success));
  jsonToSend.AddPair('user_id', TJSONNumber.Create(user_id));
  jsonToSend.AddPair('role', TJSONNumber.Create(role));
  Socket.SendText(jsonToSend.ToString);
end;


procedure create_admin_user(receivedJson: TJSONObject);
var
  username, password: String;
begin
  username := getJsonStringAttribute(receivedJson, 'username');
  password := getJsonStringAttribute(receivedJson, 'password');
  dm.CreateUser(username, password, 0);
end;


procedure create_operator(receivedJson: TJSONObject);
var
  surname, name, patronymic, username, password: String;
begin
  surname := getJsonStringAttribute(receivedJson, 'surname');
  name := getJsonStringAttribute(receivedJson, 'name');
  patronymic := getJsonStringAttribute(receivedJson, 'patronymic');
  username := getJsonStringAttribute(receivedJson, 'username');
  password := getJsonStringAttribute(receivedJson, 'password');
  dm.CreateOperator(surname, name, patronymic, username, password);
end;

end.
