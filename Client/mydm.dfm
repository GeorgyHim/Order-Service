object dm: Tdm
  OldCreateOrder = False
  Height = 689
  Width = 531
  object IBDatabase1: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 312
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 408
    Top = 16
  end
  object tAddress: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'ADDRESS'
    UniDirectional = False
    Left = 304
    Top = 72
  end
  object tClient: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'CLIENT'
    UniDirectional = False
    Left = 352
    Top = 72
  end
  object tCourier: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'COURIER'
    UniDirectional = False
    Left = 400
    Top = 72
  end
  object tOrderList: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'ORDER_LIST'
    UniDirectional = False
    Left = 448
    Top = 72
  end
  object tOrders: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'ORDERS'
    UniDirectional = False
    Left = 496
    Top = 72
  end
  object spAddAddress: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_ADDRESS'
    Left = 392
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IN_CLIENT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_ADDRESS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'OUT_ID'
        ParamType = ptOutput
      end>
  end
  object spAddClient: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_CLIENT'
    Left = 464
    Top = 128
    ParamData = <
      item
        DataType = ftWideString
        Name = 'IN_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_PHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'OUT_ID'
        ParamType = ptOutput
      end>
  end
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
  object spAddOrder: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_ORDER'
    Left = 312
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'OUT_ID'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'IN_COURIER_ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IN_ADDRESS_ID'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_TIME_START'
        ParamType = ptInput
      end>
  end
  object spAddOrderList: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_ORDER_LIST'
    Left = 376
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'OUT_ID'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'IN_ORDERS_ID'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_POSITION_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'IN_PRICE'
        ParamType = ptInput
      end>
  end
  object spConfirmOrder: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'CONFIRM_ORDER'
    Left = 456
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IN_ID'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_TIME_END'
        ParamType = ptInput
      end>
  end
  object spHasNewOrder: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'HAS_NEW_ORDER'
    Left = 400
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IN_ID'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'OUT_HAS_NEW_ORDER'
        ParamType = ptOutput
      end>
  end
  object dsCourierOrder_List: TDataSource
    Left = 456
    Top = 304
  end
  object spSetReport: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'SET_REPORTED'
    Left = 472
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IN_ORDER_ID'
        ParamType = ptInput
      end>
  end
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
end
