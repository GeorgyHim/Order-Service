unit utils;

interface
uses System.SysUtils, System.JSON;

function getJsonStringAttribute(jsonObject: TJSONObject; key: String): String;

implementation
function getJsonStringAttribute(jsonObject: TJSONObject; key: String): String;
begin
  result := jsonObject.GetValue(key).ToString;
  result := Copy(result, 2, result.Length - 2);
end;

end.
