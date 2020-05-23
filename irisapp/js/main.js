const CAR_GET_ALL_URL = "/racetournament/car/getall";
const CAR_GET_SELECT_LIST = "/racetournament/car/getselectlist";
const CAR_DELETE_URL = "/racetournament/car/delete";
const CAR_ADD_URL = "/racetournament/car/add";
const CAR_EDIT_URL = "/racetournament/car/edit";

const PLACE_GET_ALL_URL = "/racetournament/place/getall";
const PLACE_GET_NAME_SELECT_LIST = "/racetournament/place/getnameselectlist";
const PLACE_DELETE_URL = "/racetournament/place/delete";
const PLACE_ADD_URL = "/racetournament/place/add";
const PLACE_EDIT_URL = "/racetournament/place/edit";

const TOUR_GET_ALL_URL = "/racetournament/tour/getall";
const TOUR_GET_NAME_SELECT_LIST = "/racetournament/tour/getnameselectlist";
const TOUR_DELETE_URL = "/racetournament/tour/delete";
const TOUR_ADD_URL = "/racetournament/tour/add";
const TOUR_EDIT_URL = "/racetournament/tour/edit";

const DRIVER_GET_ALL_URL = "/racetournament/driver/getall";
const DRIVER_GET_NAME_SELECT_LIST = "/racetournament/driver/getnameselectlist";
const DRIVER_DELETE_URL = "/racetournament/driver/delete";
const DRIVER_ADD_URL = "/racetournament/driver/add";
const DRIVER_EDIT_URL = "/racetournament/driver/edit";
const RESULT_LOAD_URL ="/racetournament/result/load";
const RESULT_GET_ALL_URL = "/racetournament/result/getall";
const RESULT_SET_URL ="/racetournament/result/set";

const menu_data = [
  {id: "tab1", icon: "mdi mdi-trophy", value:"Tournament Results"},
  {id: "tab2", icon: "mdi mdi-car-sports", value:"Cars"},
  {id: "tab3", icon: "mdi mdi-stadium", value:"Places"},
  {id: "tab4", icon: "mdi mdi-flag-checkered", value:"Tours"},
  {id: "tab5", icon: "mdi mdi-account", value:"Drivers"}
];

const startPage = {
  id: "start_content",
  view: "label",
  height: '100%',
  width: '100%',
  label: "Welcome to the start page!",
}

var submitCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  var i;
  for(i = 0; i < data.length; i++) {
    if (data[i].result) {
      message = { type:"success", text: "profile is load", expire: 2000};
    }
    else {
      message = { type:"error", text: data.message, expire:2000};
    }
    webix.message(message);
  }
};

var setResultCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Result set", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

const resultTab = {
  id:"tab1_content",
  autowidth: true,
  rows: [
    { id: "tab1_dt",
      view: "datatable",
      height: "500",
      autowidth: true,
      columns:[
        { id:"id", header:"Id",  		width:50},
        { id:"driver",	header:"Driver", width:150},
        { id:"car", header:"Car", 	width:100},
        { id:"tour",  header: "Tour", width:150},
        { id:"time", editor: "text", header: "Time", width: 70}
      ],
      editable:true,
      editaction:"dblclick",
      select: "row",
      on:{
        onAfterLoad:function(){
          if (!this.count())
            this.showOverlay("Sorry, there is no data");
        }
      },
      url: RESULT_GET_ALL_URL
    },
    { cols: [
      { view:"button",  value:"Load Empty Template", id:"load_button", click:function(){
        webix.message("Loading...");
        webix.ajax().get(RESULT_LOAD_URL, { proc: "loading"} , submitCallback);
        webix.message("Update page");
      }},
      { view:"button",  value:"Submit", id:"submit_button", click:function(){
        $$("tab1_dt").editStop();
        var row_id = $$("tab1_dt").getSelectedId();
        if(row_id) {
          var obj = $$("tab1_dt").getSelectedItem(true);
          var id = obj[0].id;
          var value = obj[0].time;
          webix.message(`Selected to edit ${row_id} : ${value}`);
          webix.ajax().post(RESULT_SET_URL, {id: id, time: value}, setResultCallback);
        }
      }}
    ]}
]};

var addCarFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Empty row is added", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var saveCarFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Car is edited", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var deleteCarFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Car is deleted", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

const carTab = {
  id:"tab2_content",
  autowidth: true,
  rows: [
    { id: "tab2_dt",
      view: "datatable",
      height: "500",
      autowidth: true,
      columns:[
        { id:"id",	header:"id", width:50},
        { id:"number", editor:"text",	header:"Number",  width:70},
        { id:"label", editor:"text",	header:"Label", width:180},
        { id:"power", editor:"text",	header:"Power", 	width:100}
      ],
      editable:true,
      editaction:"dblclick",
      select: "row",
      on:{
        onAfterLoad:function(){
          if (!this.count())
            this.showOverlay("Sorry, there is no data");
        }
      },
      url: CAR_GET_ALL_URL
    },
    { cols: [
      { view:"button",  value:"Add Empty Row", id:"tab2_add_button", click:function(){
          var new_row = { number: "", label: "" , power: ""};
          $$("tab2_dt").add(new_row);
          webix.ajax().post(CAR_ADD_URL, new_row, addCarFormCallback);
      }},
      { view:"button",  value:"Save Row", id:"tab2_save_button", click:function(){
        var row_id = $$("tab2_dt").getSelectedId();
        if(row_id) {
          var obj = $$("tab2_dt").getSelectedItem(true);
          var values = obj[0];
          webix.message(`Selected to edit ${row_id} : ${values}`);
          webix.ajax().post(CAR_EDIT_URL, values, saveCarFormCallback);
        }
      }},
      { view:"button",  value:"Delete Row", id:"tab2_delete_button", click:function(){
        var row_id = $$("tab2_dt").getSelectedId(true);
        if(row_id) {
          var obj = $$("tab2_dt").getSelectedItem(true);
          var value = obj[0].id;
          webix.message(`Selected to delete ${value}`);
          $$("tab2_dt").remove(row_id);
          webix.ajax().del(CAR_DELETE_URL, {id: value}, deleteCarFormCallback);
        }
      }}
    ]}
]};

var addPlaceFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Empty row is added", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var savePlaceFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Place is edited", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var deletePlaceFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Place is deleted", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

const placeTab = {
  id:"tab3_content",
  autowidth: true,
  rows: [
    { id: "tab3_dt",
      view: "datatable",
      height: "500",
      autowidth: true,
      columns:[
        { id:"id", header:"Id",  		width:50},
        { id:"name", editor:"text",	header:"Name", width:200},
        { id:"length", editor:"text",	header:"Length", 	width:150}
      ],
      editable:true,
      editaction:"dblclick",
      select: "row",
      on:{
        onAfterLoad:function(){
          if (!this.count())
            this.showOverlay("Sorry, there is no data");
        }
      },
      url: PLACE_GET_ALL_URL
    },
    { cols: [
      { view:"button",  value:"Add Empty Row", id:"tab3_add_button", click:function(){
          var new_row = { name: "", length: "" };
          $$("tab3_dt").add(new_row);
          webix.ajax().post(PLACE_ADD_URL, new_row, addPlaceFormCallback);
      }},
      { view:"button",  value:"Save Row", id:"tab3_save_button", click:function(){
        var row_id = $$("tab3_dt").getSelectedId();
        if(row_id) {
          var obj = $$("tab3_dt").getSelectedItem(true);
          var values = obj[0];
          webix.message(`Selected to edit ${row_id} : ${values}`);
          webix.ajax().post(PLACE_EDIT_URL, values, savePlaceFormCallback);
        }
      }},
      { view:"button",  value:"Delete Row", id:"tab3_delete_button", click:function(){
        var row_id = $$("tab3_dt").getSelectedId(true);
        if(row_id) {
          var obj = $$("tab3_dt").getSelectedItem(true);
          var value = obj[0].id;
          webix.message(`Selected to delete ${value}`);
          $$("tab3_dt").remove(row_id);
          webix.ajax().del(PLACE_DELETE_URL, {id: value}, deletePlaceFormCallback);
        }
      }}
    ]}
]};

var addTourFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Empty row is added", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var saveTourFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Tour is edited", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var deleteTourFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Tour is deleted", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

const tourTab = {
  id:"tab4_content",
  autowidth: true,
  rows: [
    { id: "tab4_dt",
      view: "datatable",
      height: "500",
      autowidth: true,
      columns:[
        { id:"id", header:"Id",  		width:50},
        { id:"name", editor:"text",	header:"Name", width:150},
        { id: "date", editor:"date",	header:"Date", 	width:150},
        { id:"placeId", editor: "richselect", options: PLACE_GET_NAME_SELECT_LIST, header: "Place", width:150}
      ],
      editable:true,
      editaction:"dblclick",
      select: "row",
      on:{
        onAfterLoad:function(){
          if (!this.count())
            this.showOverlay("Sorry, there is no data");
        }
      },
      url: TOUR_GET_ALL_URL
    },
    { cols: [
      { view:"button",  value:"Add Empty Row", id:"tab4_add_button", click:function(){
          var firstRowId = $$("tab3_dt").getFirstId();
          var firstRow = $$("tab3_dt").getItem(firstRowId);
          var new_row = { name: "", date: "2020-01-01", placeId: firstRow.id};
          $$("tab4_dt").add(new_row);
          webix.ajax().post(TOUR_ADD_URL, new_row, addTourFormCallback);
      }},
      { view:"button",  value:"Save Row", id:"tab4_save_button", click:function(){
        $$("tab4_dt").editStop();
        var row_id = $$("tab4_dt").getSelectedId();
        if(row_id) {
          var obj = $$("tab4_dt").getSelectedItem(true);
          var values = obj[0];
          var print = JSON.stringify(values);
          webix.message(`Selected to edit ${row_id} : ${print}`);
          webix.ajax().post(TOUR_EDIT_URL, values, saveTourFormCallback);
        }
      }},
      { view:"button",  value:"Delete Row", id:"tab4_delete_button", click:function(){
        var row_id = $$("tab4_dt").getSelectedId(true);
        if(row_id) {
          var obj = $$("tab4_dt").getSelectedItem(true);
          var value = obj[0].id;
          webix.message(`Selected to delete ${value}`);
          $$("tab4_dt").remove(row_id);
          webix.ajax().del(TOUR_DELETE_URL, {id: value}, deleteTourFormCallback);
        }
      }}
    ]}
]};

var addDriverFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Empty row is added", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var saveDriverFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Driver's profile is edited", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

var deleteDriverFormCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Driver is deleted", expire: 2000};
  }
  else {
    message = { type:"error", text: data.message, expire:2000};
  }
  webix.message(message);
};

const driverTab = {
  id:"tab5_content",
  autowidth: true,
  rows: [
    { id: "tab5_dt",
      view: "datatable",
      height: "500",
      autowidth: true,
      columns:[
        { id:"id", header:"Id",  		width:50},
        { id:"name", editor:"text",	header:"Name", width:150},
        { id:"age", editor:"text",	header:"Age", 	width:100},
        { id:"carId", editor: "richselect", options: CAR_GET_SELECT_LIST, header: "Car", width:150},
        { id:"tourId", editor: "richselect", options: TOUR_GET_NAME_SELECT_LIST, header: "Tour", width:150}
      ],
      editable:true,
      editaction:"dblclick",
      select: "row",
      on:{
        onAfterLoad:function(){
          if (!this.count())
            this.showOverlay("Sorry, there is no data");
        }
      },
      url: DRIVER_GET_ALL_URL
    },
    { cols: [
      { view:"button",  value:"Add Empty Row", id:"tab5_add_button", click:function(){
          var firstCarId = $$("tab2_dt").getFirstId();
          var firstTourId = $$("tab4_dt").getFirstId();
          var firstCar = $$("tab2_dt").getItem(firstCarId);
          var firstTour = $$("tab4_dt").getItem(firstTourId);
          var new_row = { name: "", age: "", carId: firstCar.id, tourId: firstTour.id};
          $$("tab5_dt").add(new_row);
          webix.ajax().post(DRIVER_ADD_URL, new_row, addDriverFormCallback);
      }},
      { view:"button",  value:"Save Row", id:"tab5_save_button", click:function(){
        $$("tab5_dt").editStop();
        var row_id = $$("tab5_dt").getSelectedId();
        if(row_id) {
          var obj = $$("tab5_dt").getSelectedItem(true);
          var values = obj[0];
          var print = JSON.stringify(values);
          webix.message(`Selected to edit ${row_id} : ${print}`);
          webix.ajax().post(DRIVER_EDIT_URL, values, saveDriverFormCallback);
        }
      }},
      { view:"button",  value:"Delete Row", id:"tab5_delete_button", click:function(){
        var row_id = $$("tab5_dt").getSelectedId(true);
        if(row_id) {
          var obj = $$("tab5_dt").getSelectedItem(true);
          var value = obj[0].id;
          webix.message(`Selected to delete ${value}`);
          $$("tab5_dt").remove(row_id);
          webix.ajax().del(DRIVER_DELETE_URL, {id: value}, deleteDriverFormCallback);
        }
      }}
    ]}
]};

const ui_template = {
height: '100%',
rows: [
  { view: "toolbar", padding:3, 
    elements: [
      { view: "button", type: "icon", icon: "mdi mdi-menu",
        width: 37, align: "left", css: "app_button", click: function(){
          $$("$sidebar1").toggle();
          $$("start_content").show();
        }
      },
      { view: "label", label: "IRIS App"}
    ]
  },
  { 
    cols:[
    {
      view: "sidebar",
      data: menu_data,
      on:{
        onAfterSelect: function(id){
          let value = this.getItem(id).value;
          webix.message(`Selected ${value}`);
          $$(`${id}_content`).show();
        }
      }
    },
    {
      id: "contex",
      cells: [
        startPage,
        resultTab,
        carTab,
        placeTab,
        tourTab,
        driverTab
      ]
    }
  ]}
]};

webix.ready(function(){
  webix.ui(ui_template);
});