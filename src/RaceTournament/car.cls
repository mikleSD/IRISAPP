Class RaceTournament.Car Extends %Persistent
{

/// Car number used in racing
Property Number As %Integer;

/// Car label (car model)
Property Label As %String;

/// Engine power in kW
Property Power As %Integer;

/// Create a new car<br>
/// <var>Number</var> - car number<br>
/// <var>Label</var> - car label or model<br>
/// <var>Power</var> - engine power in kW<br>
ClassMethod create(Number As %Integer, Label As %String, Power As %Integer) As RaceTournament.Car
{
    set car = ..%New()
    set car.Number = Number
    set car.Label = Label
    set car.Power = Power
    set st =  car.%Save()
    return car
}

/// Save request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Number = reqObj.Get("number")
  set obj.Label = reqObj.Get("label")
  set obj.Power = reqObj.Get("power")
  set saveResult = obj.%Save()
  
  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all cars from the table
ClassMethod getAll() As %DynamicArray
{
    set cars = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Car")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "number": (data.Number),
            "label": (data.Label),
            "power": (data.Power)
        }
        do cars.%Push(obj)
    }
    return cars.%ToJSON()
}

/// Get car number and label list for select editor
ClassMethod getSelectList() As %DynamicArray
{
    set cars = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Car")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Number_" "_data.Label)
        }
        do cars.%Push(obj)
    }
    return cars.%ToJSON()
}

/// Edit car
/// <var>reqObj</var> - request obj
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set car = ..%OpenId(Id)
    set result = {}

    if $IsObject(car) {
        set car.Number = reqObj.Get("number")
        set car.Label = reqObj.Get("label")
        set car.Power = reqObj.Get("power")
        set saveResult = car.%Save()
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    }
    else {
        set result = {"result": false}
        set result.message = "Invalid object"
    }
    
    return result.%ToJSON()
}

/// Delete car from table by id
/// <var>Id</var> - car id in the table
ClassMethod delete(Id As %String = "") As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.message = ErrorMessage
    return result.%ToJSON()
}

Storage Default
{
<Data name="CarDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Number</Value>
</Value>
<Value name="3">
<Value>Label</Value>
</Value>
<Value name="4">
<Value>Power</Value>
</Value>
</Data>
<DataLocation>^RaceTournament.CarD</DataLocation>
<DefaultData>CarDefaultData</DefaultData>
<IdLocation>^RaceTournament.CarD</IdLocation>
<IndexLocation>^RaceTournament.CarI</IndexLocation>
<StreamLocation>^RaceTournament.CarS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
