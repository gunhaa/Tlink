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


function chart2(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      const seriesData=[];
      const labelsData=[];
      for(let i=0; i<list.length;i++){

          seriesData[i] = milliTerms(list[i].createDate,list[i].dueDate);
          labelsData[i] = list[i].workTitle;
      }
      
        var options = {
          series: seriesData,
          chart: {
          width: 600,
          height: 300,
          type: 'pie',
        },
        labels: labelsData,
        responsive: [{
          breakpoint: 480,
          options: {
            chart: {
              width: 600,
              height: 300,
            },
            legend: {
              position: 'bottom'
            }
          }
        }]
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
      const list=res;

      const seriesData=[];
      const labelsData=[];
      const colorsData=[];
      for(let i=0; i<list.length;i++){

          seriesData[i] = milliTermsDay(list[i].createDate,list[i].dueDate);
          labelsData[i] = list[i].workTitle;
      }
      
      var options = {
        series: seriesData,
        chart: {
        width: 600,
        height: 600,
        type: 'radialBar',
      },
      plotOptions: {
        radialBar: {
          offsetY: 0,
          startAngle: 0,
          endAngle: 270,
          hollow: {
            margin: 5,
            size: '30%',
            background: 'transparent',
            image: undefined,
          },
          dataLabels: {
            name: {
              show: false,
            },
            value: {
              show: false,
            }
          },
          barLabels: {
            enabled: true,
            useSeriesColors: true,
            offsetX: 0,
            fontSize: '16px',
            formatter: function(seriesName, opts) {
              return seriesName + ":  " + opts.w.globals.series[opts.seriesIndex]
            },
          },
        }
      },
      colors: ['#1ab7ea', '#0084ff', '#39539E', '#0077B5'],
      labels: labelsData,
      responsive: [{
        breakpoint: 480,
        options: {
          legend: {
              show: false
          }
        }
      }]
      };

      var chart = new ApexCharts(document.querySelector("#chart3"), options);
      chart.render();



  })
  .catch(err => console.log(err))
    
}
chart3();


function chart4(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      const seriesData=[];
      let sum=0;
      const length=list.length;
      for(let i=0; i<list.length;i++){
          list[i].createDate >= list[i].dueDate ? sum+=1 : sum+=0 ;
        }
      seriesData[0]=sum/length*100;
      

      var options = {
        series: seriesData,
        chart: {
        width: 300,
        height: 300,
        type: 'radialBar',
        toolbar: {
          show: true
        }
      },
      plotOptions: {
        radialBar: {
          startAngle: -135,
          endAngle: 225,
           hollow: {
            margin: 0,
            size: '70%',
            background: '#fff',
            image: undefined,
            imageOffsetX: 0,
            imageOffsetY: 0,
            position: 'front',
            dropShadow: {
              enabled: true,
              top: 3,
              left: 0,
              blur: 4,
              opacity: 0.24
            }
          },
          track: {
            background: '#fff',
            strokeWidth: '67%',
            margin: 0, // margin is in pixels
            dropShadow: {
              enabled: true,
              top: -3,
              left: 0,
              blur: 4,
              opacity: 0.35
            }
          },
      
          dataLabels: {
            show: true,
            name: {
              offsetY: -10,
              show: true,
              color: '#888',
              fontSize: '17px'
            },
            value: {
              formatter: function(val) {
                return parseInt(val);
              },
              color: '#111',
              fontSize: '36px',
              show: true,
            }
          }
        }
      },
      fill: {
        type: 'gradient',
        gradient: {
          shade: 'dark',
          type: 'horizontal',
          shadeIntensity: 0.5,
          gradientToColors: ['#ABE5A1'],
          inverseColors: true,
          opacityFrom: 1,
          opacityTo: 1,
          stops: [0, 100]
        }
      },
      stroke: {
        lineCap: 'round'
      },
      labels: ['Done(%)'],
      };

      var chart = new ApexCharts(document.querySelector("#chart4"), options);
      chart.render();



  })
  .catch(err => console.log(err))

}
chart4();




function chart4_1(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      const seriesData=[];
      let sum=0;
      const length=list.length;
      for(let i=0; i<list.length;i++){
          list[i].createDate < list[i].dueDate ? sum+=1 : sum+=0 ;
      }
      seriesData[0]=sum/length*100;
      

      var options = {
        series: seriesData,
        chart: {
        width: 300,
        height: 300,
        type: 'radialBar',
        toolbar: {
          show: true
        }
      },
      plotOptions: {
        radialBar: {
          startAngle: -135,
          endAngle: 225,
           hollow: {
            margin: 0,
            size: '70%',
            background: '#fff',
            image: undefined,
            imageOffsetX: 0,
            imageOffsetY: 0,
            position: 'front',
            dropShadow: {
              enabled: true,
              top: 3,
              left: 0,
              blur: 4,
              opacity: 0.24
            }
          },
          track: {
            background: '#fff',
            strokeWidth: '67%',
            margin: 0, // margin is in pixels
            dropShadow: {
              enabled: true,
              top: -3,
              left: 0,
              blur: 4,
              opacity: 0.35
            }
          },
      
          dataLabels: {
            show: true,
            name: {
              offsetY: -10,
              show: true,
              color: '#888',
              fontSize: '17px'
            },
            value: {
              formatter: function(val) {
                return parseInt(val);
              },
              color: '#111',
              fontSize: '36px',
              show: true,
            }
          }
        }
      },
      fill: {
        type: 'gradient',
        gradient: {
          shade: 'dark',
          type: 'horizontal',
          shadeIntensity: 0.5,
          gradientToColors: ['#e5a1bd'],
          inverseColors: true,
          opacityFrom: 1,
          opacityTo: 1,
          stops: [0, 100]
        }
      },
      stroke: {
        lineCap: 'round'
      },
      labels: ['Undone(%)'],
      };

      var chart = new ApexCharts(document.querySelector("#chart4-1"), options);
      chart.render();



  })
  .catch(err => console.log(err))

}
chart4_1();



function chart5(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      const chartData=[];
      for(let i=0; i<list.length;i++){
          chartData[i] = {};
          chartData[i].x=list[i].workTitle;
          chartData[i].y=milliTermsDay(list[i].createDate,list[i].dueDate);
      }

      var options = {
        series: [
        {
          data: chartData
        }
      ],
        legend: {
        show: false
      },
      chart: {
        width: 600,
        height: 600,
        type: 'treemap'
      },
      title: {
        text: 'Distibuted Treemap (different color for each cell)',
        align: 'center'
      },
      colors: [
        '#3B93A5',
        '#F7B844',
        '#ADD8C7',
        '#EC3C65',
        '#CDD7B6',
        '#C1F666',
        '#D43F97',
        '#1E5D8C',
        '#421243',
        '#7F94B0',
        '#EF6537',
        '#C0ADDB'
      ],
      plotOptions: {
        treemap: {
          distributed: true,
          enableShades: false
        }
      }
      };

      var chart = new ApexCharts(document.querySelector("#chart5"), options);
      chart.render();



  })
  .catch(err => console.log(err))

}
chart5();





function chart6(){

  const data={ "projectNo"      : projectNo_, };
  fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
  .then (rep => rep.json())
  .then (res => { 
      console.log(res); 
      const list=res;

      let nameData=``;
      const dataData=[];
      const categoriesData=[];

      nameData=list[0].projectName;

      for(let i=0; i<list.length;i++){
          dataData[i]=milliTermsDay(list[i].createDate,list[i].dueDate);
          categoriesData[i]=dueDay(list[i].dueDate);
      }



      var options = {
        series: [{
        name: nameData,
        data: dataData,
      }],
        chart: {
        width: 600,
        height: 600,
        type: 'radar',
      },
      dataLabels: {
        enabled: true
      },
      plotOptions: {
        radar: {
          size: 140,
          polygons: {
            strokeColors: '#e9e9e9',
            fill: {
              colors: ['#f8f8f8', '#fff']
            }
          }
        }
      },
      title: {
        text: 'Radar with Polygon Fill'
      },
      colors: ['#FF4560'],
      markers: {
        size: 4,
        colors: ['#fff'],
        strokeColor: '#FF4560',
        strokeWidth: 2,
      },
      tooltip: {
        y: {
          formatter: function(val) {
            return val
          }
        }
      },
      xaxis: {
        categories: categoriesData
      },
      yaxis: {
        labels: {
          formatter: function(val, i) {
            if (i % 2 === 0) {
              return val
            } else {
              return ''
            }
          }
        }
      }
      };

      var chart = new ApexCharts(document.querySelector("#chart6"), options);
      chart.render();




  })
  .catch(err => console.log(err))

}
chart6();


