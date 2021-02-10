object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 689
  Width = 531
  object spAddUser: TIBStoredProc
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    StoredProcName = 'ADD_USER'
    Left = 128
    Top = 80
    ParamData = <
      item
        DataType = ftWideString
        Name = 'USERNAME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'PASSWORD'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'ROLE'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'OUT_ID'
        ParamType = ptOutput
      end>
  end
  object IBDatabase: TIBDatabase
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
  object IBTransaction_Edit: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 208
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
  object qCreateOperator: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'INSERT INTO OPERATOR(USER_ID, NAME,  SURNAME, PATRONYMIC)'
      'VALUES (:USER_ID, :NAME, :SURNAME, :PATRONYMIC)')
    Left = 24
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USER_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SURNAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PATRONYMIC'
        ParamType = ptUnknown
      end>
  end
  object qCreateRestaurant: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'INSERT INTO RESTAURANT(USER_ID, NAME, ADRESS,  START_HOUR, END_H' +
        'OUR, MENU)'
      'VALUES (:USER_ID, :NAME, :ADRESS, :START_HOUR, :END_HOUR, :MENU)')
    Left = 128
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USER_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADRESS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'START_HOUR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'END_HOUR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MENU'
        ParamType = ptUnknown
      end>
  end
  object qAllAdmins: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT USERNAME'
      'FROM USER2'
      'WHERE IS_ACTIVE=1 and ROLE=0'
      'ORDER BY username;')
    Left = 8
    Top = 216
  end
  object qAllOperators: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT SURNAME, NAME, PATRONYMIC, USERNAME'
      'FROM operator '
      '    INNER JOIN user2 ON operator.user_id = user2.id'
      'WHERE IS_ACTIVE=1'
      'ORDER BY SURNAME, NAME, PATRONYMIC;')
    Left = 80
    Top = 216
  end
  object qAllRestaurants: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT NAME, ADRESS, START_HOUR, END_HOUR, MENU, USERNAME'
      'FROM restaurant'
      '    INNER JOIN user2 ON restaurant.user_id = user2.id'
      'WHERE IS_ACTIVE=1'
      'ORDER BY START_HOUR, END_HOUR DESC, NAME;')
    Left = 160
    Top = 216
  end
  object qAllOrders: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT order2.id, restaurant.NAME as restoraunt, ADRESS,'
      '    SURNAME||'#39' '#39'||operator.name||'#39'('#39'||operator_id||'#39')'#39' as oper,'
      '    START_HOUR, END_HOUR, CLIENT_PHONE, INFO, STATUS,'
      '    START_TIME, PREDICTED_END_TIME, REAL_END_TIME'
      'FROM  order2'
      '    INNER JOIN restaurant ON restaurant_id = restaurant.id'
      '    INNER JOIN operator ON operator_id = operator.id'
      'ORDER BY order2.id;')
    Left = 232
    Top = 216
  end
  object qDeactivate: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE USER2 '
      'SET IS_ACTIVE=0 '
      'WHERE USERNAME=:USERNAME')
    Left = 24
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'username'
        ParamType = ptUnknown
      end>
  end
  object qAllDeactivatedUsers: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT USERNAME, ROLE,'
      
        '    operator.surname||'#39' '#39'||operator.name||'#39'('#39'||operator.id||'#39')'#39' ' +
        'as "operator",'
      '    restaurant.name as restaurant_name'
      'FROM user2'
      'LEFT JOIN operator  ON operator.user_id = user2.id'
      'LEFT JOIN  restaurant ON restaurant.user_id = user2.id'
      'WHERE IS_ACTIVE=0'
      'ORDER BY ROLE;')
    Left = 320
    Top = 216
  end
  object qActivate: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE USER2 '
      'SET IS_ACTIVE=1 '
      'WHERE USERNAME=:USERNAME')
    Left = 96
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'username'
        ParamType = ptUnknown
      end>
  end
  object qChangePassword: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction_Edit
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE USER2 '
      'SET PASSWORD = :PASSWORD'
      'WHERE USERNAME=:USERNAME')
    Left = 208
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PASSWORD'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'USERNAME'
        ParamType = ptUnknown
      end>
  end
end
