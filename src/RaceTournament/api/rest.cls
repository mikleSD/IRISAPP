Class RaceTournament.Api.Rest Extends %CSP.REST
{

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="Test"/>

  <Route Url="/car/getall" Method="GET" Call="CarGetAll"/>
  <Route Url="/car/getselectlist" Method="GET" Call="CarGetSelectList"/>
  <Route Url="/car/delete" Method="DELETE" Call="CarDelete"/>
  <Route Url="/car/add" Method="POST" Call="CarAdd"/>
  <Route Url="/car/edit" Method="POST" Call="CarEdit"/>
  
  <Route Url="/place/getall" Method="GET" Call="PlaceGetAll"/>
  <Route Url="/place/getnameselectlist" Method="GET" Call="PlaceGetNameSelectList"/>
  <Route Url="/place/delete" Method="DELETE" Call="PlaceDelete"/>
  <Route Url="/place/add" Method="POST" Call="PlaceAdd"/>
  <Route Url="/place/edit" Method="POST" Call="PlaceEdit"/>

  <Route Url="/tour/getall" Method="GET" Call="TourGetAll"/>
  <Route Url="/tour/getnameselectlist" Method="GET" Call="TourGetNameSelectList"/>
  <Route Url="/tour/delete" Method="DELETE" Call="TourDelete"/>
  <Route Url="/tour/add" Method="POST" Call="TourAdd"/>
  <Route Url="/tour/edit" Method="POST" Call="TourEdit"/>

  <Route Url="/driver/getall" Method="GET" Call="DriverGetAll"/>
  <Route Url="/driver/getnameselectlist" Method="GET" Call="DriverGetNameSelectList"/>
  <Route Url="/driver/delete" Method="DELETE" Call="DriverDelete"/>
  <Route Url="/driver/add" Method="POST" Call="DriverAdd"/>
  <Route Url="/driver/edit" Method="POST" Call="DriverEdit"/>

  <Route Url="/result/load" Method="GET" Call="ResultLoad"/>
  <Route Url="/result/getall" Method="GET" Call="ResultGetAll"/>
  <Route Url="/result/set" Method="POST" Call="ResultSet"/>
</Routes>
}

ClassMethod Test() As %Status
{
  write "hello this is test"
  return $$$OK
}

ClassMethod CarGetAll() As %Status
{
  Try {
    write ##class(RaceTournament.Car).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod CarGetSelectList() As %Status
{
  Try {
    write ##class(RaceTournament.Car).getSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod CarDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(RaceTournament.Car).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod CarAdd() As %Status
{
  set result = ##class(RaceTournament.Car).add(%request)
  write result
  return $$$OK
}

ClassMethod CarEdit() As %Status
{
  set result = ##class(RaceTournament.Car).edit(%request)
  write result
  return $$$OK
}

ClassMethod PlaceGetAll() As %Status
{
  Try {
    write ##class(RaceTournament.Place).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod PlaceGetNameSelectList() As %Status
{
  Try {
    write ##class(RaceTournament.Place).getNameSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod PlaceDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(RaceTournament.Place).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod PlaceAdd() As %Status
{
  set result = ##class(RaceTournament.Place).add(%request)
  write result
  return $$$OK
}

ClassMethod PlaceEdit() As %Status
{
  set result = ##class(RaceTournament.Place).edit(%request)
  write result
  return $$$OK
}

ClassMethod TourGetAll() As %Status
{
  Try {
    write ##class(RaceTournament.Tour).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod TourGetNameSelectList() As %Status
{
  Try {
    write ##class(RaceTournament.Tour).getNameSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod TourDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(RaceTournament.Tour).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod TourAdd() As %Status
{
  set result = ##class(RaceTournament.Tour).add(%request)
  write result
  return $$$OK
}

ClassMethod TourEdit() As %Status
{
  set result = ##class(RaceTournament.Tour).edit(%request)
  write result
  return $$$OK
}

ClassMethod DriverGetAll() As %Status
{
  Try {
    write ##class(RaceTournament.Driver).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod DriverGetNameSelectList() As %Status
{
  Try {
    write ##class(RaceTournament.Driver).getNameSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod DriverDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(RaceTournament.Driver).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod DriverAdd() As %Status
{
  set result = ##class(RaceTournament.Driver).add(%request)
  write result
  return $$$OK
}

ClassMethod DriverEdit() As %Status
{
  set result = ##class(RaceTournament.Driver).edit(%request)
  write result
  return $$$OK
}

ClassMethod ResultLoad() As %Status
{
  set result = ##class(RaceTournament.Result).loadTemplate()
  write result
  return $$$OK
}

ClassMethod ResultGetAll() As %Status
{
  Try {
    write ##class(RaceTournament.Result).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod ResultSet() As %Status
{
  set result = ##class(RaceTournament.Result).setResult(%request)
  write result
  return $$$OK
}

}
