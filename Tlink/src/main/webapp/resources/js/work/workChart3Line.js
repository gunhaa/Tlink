function selectWork(){
  let list;
  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      // console.log(res); 
       list=res;
  })
  .catch(err => console.log(err))
  return list;
}

function milliseconds(dateString) {
  const date = new Date(dateString);
  return date.getTime();
}
function milliDays(dateString) {
  const millis=milliseconds(dateString);
  const msPerDay = 24 * 60 * 60 * 1000;  
  return millis/msPerDay;
}
function milliDaysOne(dateString) {
  const num=milliDays(dateString);
  if (num === 0) return "0.0";
  const magnitude = Math.floor(Math.log10(num));
  const scaled = num / Math.pow(10, magnitude);
  const rounded = Math.round(scaled * 10) / 10;
  return rounded;
}


function milliTerms(dateString1, dateString2) {
const date1 = new Date(dateString1);
const date2 = new Date(dateString2);
const term=date2.getTime()-date1.getTime();
return term;
}

function milliTermsDay(dateString1, dateString2) {
const milliTermsSeconds= milliTerms(dateString1, dateString2);
const msPerDay = 24 * 60 * 60 * 1000;  
return milliTermsSeconds / msPerDay; 

}

function dueDay(dateString){
  const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  const date = new Date(dateString);
  const dayName = daysOfWeek[date.getDay()];
  return dayName;
}

function dueDayThree(dateString){
  const dayName = dueDay(dateString);
  return dayName.slice(0, 3);
}

function dateMonthThree(dateString) {
  const months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  const date = new Date(dateString);
  const monthName = months[date.getMonth()];
  return monthName.slice(0, 3);
}

function dateDate(dateString) {
  const date = new Date(dateString);
  return date.getDate();
}

function dateYear(dateString) {
  const date = new Date(dateString);
  return date.getFullYear();
}


function sortDatesByDay(dateArray) {
  return dateArray.sort((a, b) => new Date(a) - new Date(b));
}



function removeDuplicates(array) {
  return [...new Set(array)];
}



function chart1(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      const seriesData=[];
      const dataData=[];
      const lineData=[];
      let minData=10**10;
      let maxData=0;
      for(let i=0; i<list.length;i++){
          dataData[i]={}
          dataData[i].x=milliDays(list[i].createDate);
          dataData[i].y=milliDays(list[i].dueDate);


          lineData[i]={}
          lineData[i].x=milliDays(list[i].createDate);
          lineData[i].y=milliDays(list[i].createDate);

          minData >= milliDays(list[i].createDate) ? minData=milliDays(list[i].createDate) : null;
          maxData <= milliDays(list[i].createDate) ? maxData=milliDays(list[i].createDate) : null;
      }


      
      var options = {
        series: [{
        name: '마감일',
        type: 'scatter',
      
        data: dataData
      }, {
        name: '생성일',
        type: 'line',
        data:
        lineData
      }],
        chart: {
        width: 500,
        height: 400,
        type: 'line',
      },
      fill: {
        type:'solid',
      },
      markers: {
        size: [6, 0]
      },
      tooltip: {
        shared: false,
        intersect: true,
      },
      legend: {
        show: false
      },
      xaxis: {
        type: 'numeric',
        min: minData,
        max: maxData,
        tickAmount: 12
      }
      };

      var chart = new ApexCharts(document.querySelector("#chart1"), options);
      chart.render();


  })
  .catch(err => console.log(err))
    
}
chart1();



function chart2(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      const seriesData=[];
      const dataData=[];
      let nameData=``;
      nameData=list[0].workTitle;



      const nameDummy=[];
      for(let i=0; i<list.length;i++){
        nameDummy[i]=list[i].workManagerName;
      }
      const nameArr=removeDuplicates(nameDummy);
      console.log(
        nameArr
      );

      
      for(let j=0; j<nameArr.length;j++){
        seriesData[j]={}
        seriesData[j].name=nameArr[j];
        seriesData[j].data=[];
      }
      console.log(
        seriesData
      );


      for(let i=0; i<list.length;i++){

          for(let j=0; j<nameArr.length;j++){
            list[i].workManagerName==nameArr[j] 
            ? seriesData[j].data.push([new Date(list[i].dueDate).getDay(), milliTermsDay(list[i].createDate, list[i].dueDate)]) 
            :  null;
          }
  
          // seriesData[i]={}
          // seriesData[i].name= list[i].workTitle;
          // seriesData[i].data=[milliDays(list[i].createDate),milliDays(list[i].dueDate) ];

          // dataData[i]=[milliDays(list[i].createDate), milliTermsDay(list[i].createDate, list[i].dueDate) ];


      }

      console.log(seriesData);
      
       

      var options = {
        series: seriesData
        ,
        chart: {
        width: 500,
        height: 400,
        type: 'scatter',
        zoom: {
          enabled: true,
          type: 'xy'
        }
      },
      xaxis: {
        tickAmount: 10,
        labels: {
          formatter: function(val) {
            return parseFloat(val).toFixed(1)
          }
        }
      },
      yaxis: {
        tickAmount: 7
      }
      };

      var chart = new ApexCharts(document.querySelector("#chart2"), options);
      chart.render();


  })
  .catch(err => console.log(err))
    
}
chart2();



function chart3(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      let list=res;

      let nameData=``;
      nameData=list[0].workTitle;
      
      const dataData=[];


      const dueArr=[];
      for(let i=0; i<list.length;i++){
        dueArr[i]=list[i].dueDate;
      }
      const sortArr=sortDatesByDay(dueArr);

      for(let i=0; i<list.length;i++){
        dataData[i]={};
        dataData[i].x=`${dateMonthThree(sortArr[i])} ${dateDate(sortArr[i])} ${dateYear(sortArr[i])}`;
        dataData[i].y=1;
        for(let j=0; j<i;j++){
          list[j].dueDate==list[i].dueDate ? dataData[i].y++ : null ;
        }

      }
      
      var options = {
        series: [{
        name: nameData,
        data: dataData,
      }],
        chart: {
        width: 1000,
        type: 'area',
        height: 400,
        animations: {
          enabled: false
        },
        zoom: {
          enabled: false
        },
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'straight'
      },
      fill: {
        opacity: 0.8,
        type: 'pattern',
        pattern: {
          style: ['verticalLines', 'horizontalLines'],
          width: 5,
          height: 6
        },
      },
      markers: {
        size: 5,
        hover: {
          size: 9
        }
      },
      title: {
        text: 'DueDate Counting',
      },
      tooltip: {
        intersect: true,
        shared: false
      },
      theme: {
        palette: 'palette1'
      },
      xaxis: {
        type: 'datetime',
      },
      yaxis: {
        title: {
          text: 'Bytes Received'
        }
      }
      };

      var chart = new ApexCharts(document.querySelector("#chart3"), options);
      chart.render();


  })
  .catch(err => console.log(err))
    
}
chart3();