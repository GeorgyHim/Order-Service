object dm: Tdm
  OldCreateOrder = False
  Height = 689
  Width = 531
  object IBDatabase1: TIBDatabase
    DatabaseName = 
      'C:\Users\Alexey\Documents\Embarcadero\Studio\test\order-service\' +
      'DELIVERY.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 56
    Top = 24
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 152
    Top = 24
  end
  object tAddress: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'ADDRESS'
    UniDirectional = False
    Left = 48
    Top = 80
  end
  object tClient: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'CLIENT'
    UniDirectional = False
    Left = 96
    Top = 80
  end
  object tCourier: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'COURIER'
    UniDirectional = False
    Left = 144
    Top = 80
  end
  object tOrderList: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'ORDER_LIST'
    UniDirectional = False
    Left = 192
    Top = 80
  end
  object tOrders: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'ORDERS'
    UniDirectional = False
    Left = 240
    Top = 80
  end
  object spAddAddress: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_ADDRESS'
    Left = 48
    Top = 144
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
    Left = 120
    Top = 144
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
  object spAddCourier: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_COURIER'
    Left = 200
    Top = 144
    ParamData = <
      item
        DataType = ftWideString
        Name = 'IN_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_SURNAME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_PHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_EMAIL'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'IN_TRANSPORT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'OUT_ID'
        ParamType = ptOutput
      end>
  end
  object spAddOrder: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'ADD_ORDER'
    Left = 48
    Top = 208
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
    Left = 120
    Top = 208
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
    Left = 200
    Top = 208
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
  object qAddresses: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM address'
      'WHERE client_id = :in_client_id')
    Left = 432
    Top = 80
    ParamData = <
      item
        DataType = ftInteger
        Name = 'in_client_id'
        ParamType = ptInput
      end>
    object qAddressesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ADDRESS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qAddressesCLIENT_ID: TIntegerField
      FieldName = 'CLIENT_ID'
      Origin = 'ADDRESS.CLIENT_ID'
    end
    object qAddressesADDRESS: TIBStringField
      FieldName = 'ADDRESS'
      Origin = 'ADDRESS.ADDRESS'
      Size = 256
    end
  end
  object dsClient: TDataSource
    DataSet = tClient
    Left = 336
    Top = 24
  end
  object dsAddress: TDataSource
    Left = 336
    Top = 80
  end
  object qCourier: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT id, name, surname, phone_number, email, transport_type FR' +
        'OM courier')
    Left = 432
    Top = 136
  end
  object dsCourier: TDataSource
    DataSet = tCourier
    Left = 336
    Top = 136
  end
  object qActiveOrder: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT orders.id, orders.start_time, courier.name, courier.surna' +
        'me, client.name, address.address, orders.is_reported'
      '    FROM orders, courier, address, client'
      
        '        WHERE orders.end_time is null AND orders.courier_id = co' +
        'urier.id'
      
        '        AND orders.address_id = address.id AND address.client_id' +
        ' = client.id'
      '            ORDER BY orders.start_time')
    Left = 432
    Top = 192
  end
  object dsActiveOrder: TDataSource
    Left = 336
    Top = 192
  end
  object qFinishedOrder: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT orders.id, orders.end_time, orders.start_time, courier.na' +
        'me, courier.surname, client.name, address.address'
      '    FROM orders, courier, address, client'
      
        '        WHERE orders.end_time is not null AND orders.courier_id ' +
        '= courier.id'
      
        '        AND orders.address_id = address.id AND address.client_id' +
        ' = client.id'
      '            ORDER BY orders.end_time')
    Left = 432
    Top = 248
  end
  object dsFinishedOrder: TDataSource
    OnDataChange = dsFinishedOrderDataChange
    Left = 336
    Top = 248
  end
  object spHasNewOrder: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'HAS_NEW_ORDER'
    Left = 48
    Top = 264
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
  object qCourierOrders: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT orders.id, address.address, orders.start_time from orders' +
        ', address'
      
        ' WHERE orders.courier_id = :in_id AND orders.end_time is null AN' +
        'D orders.address_id = address.id'
      'AND orders.is_reported = '#39'FALSE'#39)
    Left = 432
    Top = 304
    ParamData = <
      item
        DataType = ftInteger
        Name = 'in_id'
        ParamType = ptInput
      end>
  end
  object dsCourierOrders: TDataSource
    Left = 336
    Top = 304
  end
  object qConfirmedOrders: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT orders.id, orders.start_time, courier.name, courier.surna' +
        'me, client.name, address.address'
      '    FROM orders, courier, address, client'
      
        '        WHERE orders.is_reported = '#39'true'#39' AND orders.courier_id ' +
        '= courier.id'
      
        '        AND orders.address_id = address.id AND address.client_id' +
        ' = client.id'
      '        AND orders.end_time is null'
      '            ORDER BY orders.start_time')
    Left = 432
    Top = 360
  end
  object dsConfirmedOrders: TDataSource
    Left = 336
    Top = 360
  end
  object qOrderList: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM order_list'
      '    WHERE orders_id = :in_order_id')
    Left = 432
    Top = 416
    ParamData = <
      item
        DataType = ftInteger
        Name = 'in_order_id'
        ParamType = ptInput
      end>
  end
  object dsOrderList: TDataSource
    Left = 336
    Top = 416
  end
  object qCourierOrder: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT NAME, PHONE_NUMBER, ADDRESS,'
      ' ORDERS.ID, IS_REPORTED, START_TIME'
      'FROM CLIENT join ADDRESS ON CLIENT.ID = ADDRESS.CLIENT_ID '
      'join ORDERS ON ADDRESS.ID = ORDERS.ADDRESS_ID '
      'WHERE ORDERS.ID = :in_order_id')
    Left = 432
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'in_order_id'
        ParamType = ptUnknown
      end>
  end
  object qCourierOrder_List: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT POSITION_NAME, PRICE'
      'FROM ORDER_LIST'
      'WHERE ORDER_LIST.ORDERS_ID = :in_order_id')
    Left = 491
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'in_order_id'
        ParamType = ptUnknown
      end>
  end
  object dsCourierOrder_List: TDataSource
    Left = 336
    Top = 536
  end
  object dsCourierOrder: TDataSource
    Left = 336
    Top = 480
  end
  object spSetReport: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'SET_REPORTED'
    Left = 120
    Top = 264
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IN_ORDER_ID'
        ParamType = ptInput
      end>
  end
end
