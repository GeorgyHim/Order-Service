object dm: Tdm
  OldCreateOrder = False
  Height = 357
  Width = 531
  object IBDatabase: TIBDatabase
    Connected = True
    DatabaseName = 'C:\'#1061#1080#1084#1096#1080#1072#1096#1074#1080#1083#1080'\'#1059#1095#1077#1073#1072'\'#1044#1077#1083#1100#1092#1080'\Order Service\DATABASE.fdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 16
    Top = 16
  end
  object IBTransaction_Read: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 104
    Top = 16
  end
  object qUserByUsername: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from USER2 WHERE username = :username;')
    Left = 32
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'username'
        ParamType = ptUnknown
      end>
  end
  object qGetRestaurantOrders: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM ORDER2'
      'WHERE STATUS IN (1, 2) '
      '    AND RESTAURANT_ID = ('
      'SELECT RESTAURANT.ID'
      'FROM RESTAURANT'
      '  INNER JOIN USER2 ON RESTAURANT.USER_ID=USER2.ID'
      'WHERE USERNAME=:LOGIN'
      ')'
      'ORDER BY STATUS, START_TIME')
    Left = 152
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LOGIN'
        ParamType = ptUnknown
      end>
  end
  object qGetOrderInfo: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT ORDER2.ID as ID, CLIENT_PHONE, '
      'STATUS, INFO, START_TIME,'
      'SURNAME||'#39' '#39'||NAME||'#39' ['#39'||operator_id||'#39']'#39' as operator'
      'FROM ORDER2'
      '    INNER JOIN OPERATOR ON operator_id = operator.id'
      'WHERE STATUS IN (1, 2) '
      '    AND ORDER2.ID = :ORDER_ID')
    Left = 264
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ORDER_ID'
        ParamType = ptUnknown
      end>
  end
  object IBTransaction_Edit: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 216
    Top = 16
  end
  object qCompleteOrderByRestaurant: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE ORDER2'
      'SET  STATUS=2'
      'WHERE ID = :ID')
    Left = 80
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
end
