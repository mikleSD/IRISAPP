Class RaceTournament.Result Extends %Persistent
{

/// Driver's profile
Property Driver As RaceTournament.Driver;

/// Time (seconds)
Property Time As %Integer;

ClassMethod loadTemplate() As %DynamicArray
{
    set result = []
    &sql(DELETE FROM RaceTournament.Result)
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Driver")
    while data.%Next() {
        set obj = ..%New()
        set id = (data.ID)
        do obj.DriverSetObjectId(id)
        set obj.Time = 0
        set saveResult = obj.%Save()

        set status = {}
        if $$$ISOK(saveResult) set status = {"result": true}
        else  set status = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set status.message = ErrorMessage
        do result.%Push(status)
    }
    Return result.%ToJSON()
}

/// Get all results array (json) from table
ClassMethod getAll() As %DynamicArray
{
    set results = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Result")
    while data.%Next() {
        set driver = ##class(RaceTournament.Driver).%OpenId(data.Driver)
        set obj = {
            "id": (data.ID),
            "driver": (driver.Name),
            "car": (driver.Car.Number_" "_driver.Car.Label),
            "tour": (driver.Tour.Name),
            "time": (data.Time)
        }
        do results.%Push(obj)
    }
    return results.%ToJSON()
}

ClassMethod setResult(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set res = ..%OpenId(Id)
    set res.Time = reqObj.Get("time")
    set saveResult = res.%Save()

    set result = {}
    if $$$ISOK(saveResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    return result.%ToJSON()
}

ClassMethod delete(Id As %String = "") As %Status
{
    set result = ..%DeleteId(Id)
    Return result
}

Storage Default
{
<Data name="ResultDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Driver</Value>
</Value>
<Value name="3">
<Value>Time</Value>
</Value>
</Data>
<DataLocation>^RaceTournament.ResultD</DataLocation>
<DefaultData>ResultDefaultData</DefaultData>
<IdLocation>^RaceTournament.ResultD</IdLocation>
<IndexLocation>^RaceTournament.ResultI</IndexLocation>
<StreamLocation>^RaceTournament.ResultS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
