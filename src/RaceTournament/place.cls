Class RaceTournament.Place Extends %Persistent
{

/// Place name
Property Name As %String;

/// Track length 
Property Length As %Integer;

/// Create a new place<br>
/// <var>Name</var> - place name<br>
/// <var>Length</var> - track length<br>
ClassMethod create(Name As %String = "", Length As %Integer = 0) As RaceTournament.Place
{
    set place = ..%New()
    set place.Name = Name
    set place.Length = Length
    set st = place.%Save()
    return place
}

/// Save a request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Name = reqObj.Get("name")
  set obj.Length = reqObj.Get("length")
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all places from the table
ClassMethod getAll() As %DynamicArray
{
    set places = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Place")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "name": (data.Name),
            "length": (data.Length)
        }

        do places.%Push(obj)
    }
    return places.%ToJSON()
}

/// Get place name list for select editor
ClassMethod getNameSelectList() As %DynamicArray
{
    set places = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Place")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Name)
        }

        do places.%Push(obj)
    }
    return places.%ToJSON()
}

/// Edit place 
/// <var>reqObj</var> - request object
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set place = ..%OpenId(Id)
    set result = {}

    if $IsObject(place) {
        set place.Name = reqObj.Get("name")
        set place.Length = reqObj.Get("length")
        set saveResult = place.%Save()

        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    } else {
        set result = {"result": false}
        set result.message = "Invalid Object"
    }
    return result.%ToJSON()
}

/// Delete place from table by id
/// <var>Id</var> - place id in the table
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
<Data name="PlaceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Length</Value>
</Value>
</Data>
<DataLocation>^RaceTournament.PlaceD</DataLocation>
<DefaultData>PlaceDefaultData</DefaultData>
<IdLocation>^RaceTournament.PlaceD</IdLocation>
<IndexLocation>^RaceTournament.PlaceI</IndexLocation>
<StreamLocation>^RaceTournament.PlaceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
