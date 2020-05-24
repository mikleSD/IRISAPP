Class RaceTournament.Tour Extends %Persistent
{

/// Race tour name
Property Name As %String;

/// Race tour date in $HOROLOG ([YY]YY-MM-DD - ODBS format)
Property Date As %Date;

/// Race tour place {Name, Coordinates, Length}
Property Place As RaceTournament.Place;

/// Create new race tour<br>
/// <var>Name</var> - race tour name<br>
/// <var>Date</var> - race tour date YYYY-MM-DD<br>
/// <var>PlaceName</var> - place name<br>
/// <var>Length</var> - track length<br> 
ClassMethod create(TourName As %String, Date As %String, PlaceName As %String = "", Length As %Integer = 0) As RaceTournament.Tour
{
    set tour = ..%New()
    set tour.Name = TourName
    set tour.Date = $ZDateh(Date, 3)
    set place = ##class(RaceTournament.Place).create(PlaceName, Length)
    do tour.PlaceSetObjectId(place.%Id())
    set st = tour.%Save()
    return tour
}

/// Save request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Name = reqObj.Get("name")
  set obj.Date = $ZDateh(reqObj.Get("date"), 3)
  do obj.PlaceSetObjectId(reqObj.Get("placeId"))
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all tour array from table
ClassMethod getAll() As %DynamicArray
{
    set tours = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Tour")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "name": (data.Name),
            "date": ($ZDate(data.Date, 3)),
            "placeId": (data.Place)
        }
        do tours.%Push(obj)
    }
    return tours.%ToJSON()
}

/// Get tour name list for select editor
ClassMethod getNameSelectList() As %DynamicArray
{
    set list = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM RaceTournament.Tour")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Name)
        }
        do list.%Push(obj)
    }
    return list.%ToJSON()
}

/// Edit tour
/// <var>reqObj</var> - request obj
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set tour = ..%OpenId(Id)
    set result = {}

    if $IsObject(tour) {
        set tour.Name = reqObj.Get("name")
        set tour.Date = $ZDateh(reqObj.Get("date"), 3)
        do tour.PlaceSetObjectId(reqObj.Get("placeId"))
        set saveResult = tour.%Save()
    
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    } else {
        set result = {"result": false}
        set result.message = "Invalid object"
    }


    return result.%ToJSON()
}

/// Delete tour from table by id
/// <var>Id</var> - tour id in the table
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
<Data name="TourDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Date</Value>
</Value>
<Value name="4">
<Value>Place</Value>
</Value>
</Data>
<DataLocation>^RaceTournament.TourD</DataLocation>
<DefaultData>TourDefaultData</DefaultData>
<IdLocation>^RaceTournament.TourD</IdLocation>
<IndexLocation>^RaceTournament.TourI</IndexLocation>
<StreamLocation>^RaceTournament.TourS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
