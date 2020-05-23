Class RaceTournament.Driver Extends %Persistent
{

Property Name As %String;

Property Age As %Integer;

Property Car As RaceTournament.Car;

Property Tour As RaceTournament.Tour;

/// Create new driver profile<br>
/// <var>Name</var> - driver's name<br>
/// <var>Age</var> - driver's age<br>
/// <var>Car</var> - car assigned to the driver on tour<br> 
/// <var>Tour</var> - tour in which the driver takes part<br>
ClassMethod create(Name As %String = "", Age As %Integer = 0, CarId As %String = "", TourId As %String = "") As RaceTournament.Driver
{
    set driver = ..%New()
    set driver.Name = Name
    set driver.Age = Age
    do driver.CarSetObjectId(CarId)
    do driver.TourSetObjectId(TourId)
    set st = driver.%Save()
    return driver
}

/// Add request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Name = reqObj.Get("name")
  set obj.Age = reqObj.Get("age")
  do obj.CarSetObjectId(reqObj.Get("carId"))
  do obj.TourSetObjectId(reqObj.Get("tourId"))
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all drivers array (json) from table
ClassMethod getAll() As %DynamicArray
{
    set drivers = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Driver")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "name": (data.Name),
            "age": (data.Age),
            "carId": (data.Car),
            "tourId": (data.Tour)
        }
        do drivers.%Push(obj)
    }
    return drivers.%ToJSON()
}

/// Get drivers names list for select editor
ClassMethod getNameSelectList() As %DynamicArray
{
    set list = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Driver")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Name)
        }
        do list.%Push(obj)
    }
    return list.%ToJSON()
}

/// Edit driver's profile
/// <var>reqObj</var> - request obj
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set driver = ..%OpenId(Id)
    set driver.Name = reqObj.Get("name")
    set driver.Age = reqObj.Get("age")
    do driver.CarSetObjectId(reqObj.Get("carId"))
    do driver.TourSetObjectId(reqObj.Get("tourId"))
    set saveResult = driver.%Save()

    set result = {}
    if $$$ISOK(saveResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    return result.%ToJSON()
}

/// Delete driver from table by id
/// <var>Id</var> - driver id in the table
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
<Data name="DriverDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Age</Value>
</Value>
<Value name="4">
<Value>Car</Value>
</Value>
<Value name="5">
<Value>Tour</Value>
</Value>
</Data>
<DataLocation>^RaceTournament.DriverD</DataLocation>
<DefaultData>DriverDefaultData</DefaultData>
<IdLocation>^RaceTournament.DriverD</IdLocation>
<IndexLocation>^RaceTournament.DriverI</IndexLocation>
<StreamLocation>^RaceTournament.DriverS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
