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


function chart0(){

    

    const data={ "projectNo"      : projectNo_, };
    fetch("/work/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => { 
        console.log(res); 
        const list=res;

        const chartData=[];
        for(let i=0; i<list.length;i++){
            chartData[i] = {};
            chartData[i].x=list[i].workTitle+`  No.${list[i].workNo}`;
            chartData[i].y=[milliseconds(list[i].createDate), milliseconds(list[i].dueDate)];
        }

        var options = {

            series: [
            {
              data: chartData
            }
          ],
            chart: {
            height: 400,
            type: 'rangeBar',
            zoom: {
              enabled: false
            }
          },
          colors: ['#EC7D31', '#36BDCB'],
          plotOptions: {
            bar: {
              horizontal: true,
              isDumbbell: true,
              dumbbellColors: [['#EC7D31', '#36BDCB']]
            }
          },
          title: {
            text: 'MilliSeconds'
          },
          legend: {
            show: true,
            showForSingleSeries: true,
            position: 'top',
            horizontalAlign: 'left',
            customLegendItems: ['CreateDate', 'DueDate']
          },
          fill: {
            type: 'gradient',
            gradient: {
              gradientToColors: ['#36BDCB'],
              inverseColors: false,
              stops: [0, 100]
            }
          },
          grid: {
            xaxis: {
              lines: {
                show: true
              }
            },
            yaxis: {
              lines: {
                show: false
              }
            }
          }
          };
          var chart = new ApexCharts(document.querySelector("#chart0"), options);
          chart.render();



    })
    .catch(err => console.log(err))


    
      
      
}
chart0();




function chart1(){

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
            chartData[i].y=[new Date(list[i].createDate).getTime(), new Date(list[i].dueDate).getTime()];
        }

        var options = {
            series: [
            {
              data: chartData
            }
          ],
            chart: {
            height: 400,
            type: 'rangeBar'
          },
          plotOptions: {
            bar: {
              horizontal: true
            }
          },
          xaxis: {
            type: 'datetime'
          }
          };
          var chart = new ApexCharts(document.querySelector("#chart1"), options);
          chart.render();


    })
    .catch(err => console.log(err))


    
      
      
}
chart1();




