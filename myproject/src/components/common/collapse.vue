<template>
    <div class="testRunResults">
        <el-input class="input" v-model="input" size="small" width="30px" placeholder="请输入筛选接口"> </el-input>
        <el-button class="searchbutton" size="small" type="success" @click="searchResults(input)">搜索</el-button>
        <el-button class="searchbutton" size="small" type="primary" @click="refresh">刷新</el-button>
        <div v-for="(item,index) in ss">
            <el-collapse v-for="(key111,value) in item" :key="value" accordion>
                <el-collapse-item :title="value" name="1">
                    <el-collapse v-for="(key,value) in key111" :key="value" accordion>
                        <el-collapse-item :title="key[Object.keys(key)[0]].name" name="1">
                            <!-- <div v-for="(item,index) in key[Object.keys(key)[0]].data"> -->
                            <div>
                                <el-table :data="key[Object.keys(key)[0]].data" border>
                                    <el-table-column prop="name" label="接口" size="small" width="240px"></el-table-column>
    
                                    <el-table-column prop="testdata" label="结果" width="480px"></el-table-column>
                                    <!-- <el-table-column prop="desc" size="small" label="描述" min-width="30%"></el-table-column> -->
    
                                </el-table>
                                <!-- <el-collapse   accordion>
                    <h1>{{item}}</h1>
              <el-collapse-item :title="item['name']" name="1">
                  
                <div  v-for="(key2,value2) in item['testdata']" :key="value2">
                    
                    <el-tag  color="green" v-if="key2=== 'true'" type="success">{{value2}}:</el-tag>
                    <el-tag  color="red"v-else-if="key2=== 'false'" type="danger">{{value2}}:</el-tag>
                    <el-tag  v-else type="primary">{{value2}}:</el-tag>
                    {{key2}}
                 </div>
              </el-collapse-item>
                </el-collapse> -->
                            </div>
    
                        </el-collapse-item>
                    </el-collapse>
    
                </el-collapse-item>
            </el-collapse>
        </div>
        <div id="charts">
           
            <div id="main" :style="{width:'100%',height:'400px'}"></div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import echarts from 'echarts'
export default {
    
    data() {
        return {
            input: '',
            oldata: [],
            ss: [],
            title: [],

        };
    },
    methods: {
        searchResults(input) {
            var that = this
            let test = []
            for (var key2 in this.ss) {
                let name = this.ss[key2]
                for (var key3 in name) {
                    if (key3.indexOf(input) !== -1) {
                        test.push(this.ss[key2])
                    }
                }
            }
            this.ss = test
            this.$nextTick(function () {

            })
        },
        refresh() {
            var that = this
            axios.get('http://localhost:8081/myapp/exResults/getAll.do', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
                that.ss = response.data
                that.title = response.data
                var title = []
                var total = []
                var success=[]
                var fail = []
                String.prototype.trim = function () {
                    return this.replace(/(^\s*)|(\s*$)/g, '');
                };
                for (var o in that.ss) {
                    var value = that.ss[o]
                    for (var key in value) {

                        var s = JSON.stringify(key).split("     总数")
                        title.push(s[0].trim())
                         var ss = JSON.stringify(s[1].trim()).split("  失败")
                         total.push(ss[0].trim().split("\"")[1])
                         fail.push(ss[1].trim().split("\\\"\"")[0])
                         success.push(ss[0].trim().split("\"")[1]-ss[1].trim().split("\\\"\"")[0])
                       
                    }

                }
                title=title.reverse()
                success=success.reverse()
                fail=fail.reverse()
                
               app.title = '堆叠条形图';

                var myChart = echarts.init(document.getElementById('main'));
                myChart.setOption({
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    legend: {
                        Width: 500,
                        data: ['success', 'fail']
                        
                       
                    },
                    grid: {
                        left: '10%',
                        right: '10%',
                        bottom: '10%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value'
                    },
                    yAxis: {
                        type: 'category',
                        data: title
                    },
                    series: [
                        {
                            name: 'success',
                            type: 'bar',
                            stack: '总量',
                            label: {
                                normal: {
                                    show: true,
                                    position: 'insideRight'
                                }
                            },
                            data: success
                        },
                        {
                            name: 'fail',
                            type: 'bar',
                            stack: '总量',
                            label: {
                                normal: {
                                    show: true,
                                    position: 'insideRight'
                                }
                            },
                            data: fail
                        }
                    ]
                });
                
            }),
            

                this.$nextTick(function () {

                })

        }


    }
}
</script>
<style>
.title1 {
    align-content: center
}
</style>
