<template>
    <div class="pos">
        <el-row>
            <el-col id="order-list" :span="12" class="pos-order">
                <el-tabs @tab-click="handleClick">
    
                    <el-tab-pane label="测试用例集合">
                        <div class="info">
                            <div class="title">登陆信息
                                <button @click="fresh">刷新</button>
                            </div>
                            <div class='userinfo'>brokerId:
                                <span class="userlogininfo">{{mydata1[0].brokerID}}</span>
                            </div>
                            <div class='userinfo'>密码:
                                <span class="userlogininfo">{{mydata1[0].password}}</span>
                            </div>
                            <div class='userinfo'>spi:
                                <span class="userlogininfo">{{mydata1[0].spi}}</span>
                            </div>
                            <div class='userinfo'>系统:
                                <span class="userlogininfo">{{mydata1[0].system}}</span>
                            </div>
                            <div class='userinfo'>用户:
                                <span class="userlogininfo">{{mydata1[0].userID}}</span>
                            </div>
                        </div>
                        <div class="filter">
                            <el-input class="input" v-model="input" size="small" width="30px" placeholder="请输入筛选接口">
                            </el-input>
                            <el-button class="searchbutton" size="small" type="success" @click="search(input)">搜索
                            </el-button>
                            <el-button class="searchbutton" size="small" type="danger" @click="update()">更新
                            </el-button>
                        </div>
    
                        <el-table :data="mydata1[0].testdata" border>
                            <el-table-column type="index" min-width="15%"></el-table-column>
                            <el-table-column prop="id" label="序号" size="small" min-width="15%"></el-table-column>
                            <el-table-column prop="name" label="接口名称" min-width="30%"></el-table-column>
                            <!-- <el-table-column prop="desc" size="small" label="描述" min-width="30%"></el-table-column> -->
                            <el-table-column label="操作" min-width="30%">
                                <template scope="scope">
                                    <el-button type="primary" size="small" @click="deltestdata(scope.$index, scope.row)">删除</el-button>
                                    <el-button type="primary" size="small" @click="addList(scope.row)">增加</el-button>
                                    <el-button type="primary" size="small" @click="showTestDetail(scope.row)">展示</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-tab-pane>
                    <el-tab-pane label="测试场景">
                        <div class="hello">
                            <el-table :data="testscene" border>
                                <el-table-column size="small" type="index" width="80"></el-table-column>
                                <!-- <el-table-column prop="id" label="序号" size="small" min-width="10%"></el-table-column> -->
                                <el-table-column prop="TestSuite" label="场景名称" width="160"></el-table-column>
                                <el-table-column label="执行进度" width="160">
                                    <template scope="scope">
                                        <el-progress :text-inside="true" :stroke-width="18" :percentage="100" status="success"></el-progress>
    
                                    </template>
    
                                </el-table-column>
                                <el-table-column label="操作" width="400">
    
                                    <template scope="scope">
                                        <el-button type="danger" size="small" @click="deltestdata11(scope.$index,scope.row)">删除</el-button>
                                        <el-button type="primary" size="small" @click="runtestscene()">执行</el-button>
                                        <el-button type="warning" size="small" @click="runtestscene()">执行详情</el-button>
    
                                    </template>
    
                                </el-table-column>
                            </el-table>
    
                        </div>
                        <div class="totalDiv">
                            <el-button type="success" size="small" min-width="30%" @click="runAll(testscene)">全部运行</el-button>
                        </div>
                    </el-tab-pane>
                    <!-- <el-tab-pane label="测试结果">
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="0"></el-progress>
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="70"></el-progress>
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="100" status="success"></el-progress>
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="50" status="exception"></el-progress>
                        </el-tab-pane> -->
                </el-tabs>
            </el-col>
            <el-col id="order-list11111" :span="12" v-if="testProgress===true">
                <collapse></collapse>
            </el-col>
            <el-col id="order-list" :span="12" v-show="showRight">
                <div class="often-goods">
                    <div class="title">主键定位
                        <button class="savebackend">同步后台</button>
                        <button class="save" @click="save">保存当前</button>
                    </div>
                    <div class="often-goods-list">
                        <ul>
                            <li>
                                <i>id: </i>
                                <input class="o-price" disabled=true v-model="oftenGoods.id" />
                            </li>
                            <li>
                                <i>name: </i>
                                <input class="o-price" disabled=true v-model="oftenGoods.name" />
                            </li>
                            <li>
                                <i>desc: </i>
                                <input class="o-price " v-model="oftenGoods.desc" />
                            </li>
                        </ul>
                    </div>
                    <div class="title">输入值</div>
                    <div class="often-goods-list">
                        <ul>
                            <li v-for="(key,value) in oftenGoods.input">
                                <i>{{value}}:
                                    <input class="o-price" v-model="oftenGoods.input[value]
                                                    "></input>
                                </i>
    
                            </li>
                        </ul>
                    </div>
                    <div class="title">输出结果</div>
                    <div class="often-goods-list">
                        <ul>
                            <li v-for="(key,value) in oftenGoods.expectResult">
                                <i>{{value}}:
                                    <input class="o-price" v-model="oftenGoods.expectResult[value]" /> </i>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="goods-type">
                </div>
            </el-col>
        </el-row>
        <div>
            <div class="addtestList-wrapper" v-show="fold">
                <div class="title">
                    <span class="suitesize">添加到场景</span>
                    <el-button type="success" size="small" class="dialog" @click="dialogFormVisible = true">添加新的测试集合</el-button>
    
                    <el-dialog title="集合" :visible.sync="dialogFormVisible">
                        <el-form :model="form">
                            <el-form-item label="集合名称" :label-width="formLabelWidth">
                                <el-input v-model="form.TestSuite" auto-complete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="集合描述" :label-width="formLabelWidth">
                                <el-input v-model="form.TestSuiteDesc" auto-complete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="集合索引" :label-width="formLabelWidth">
                                <el-input v-model="form.id" auto-complete="off"></el-input>
                            </el-form-item>
    
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="dialogFormVisible = false">取 消</el-button>
                            <el-button type="primary" @click="addnewTestsuite()">确 定</el-button>
                        </div>
                    </el-dialog>
                    <el-button type="success" size="small" class="save" @click="quit()">退出</el-button>
                </div>
                <el-row>
                    <el-col id="order-list" :span="12" class="pos-order">
                        <el-tabs>
                            <!-- <!--  -->
    
                            <div class="info">
                                <div class='userinfo'>用例集:
                                    <span class="userlogininfo">{{testSuite.name}}</span>
                                </div>
                                <div class='userinfo'>回调函数:
                                    <span class="userlogininfo">{{testSuite.spi}}</span>
                                </div>
                                <div class='userinfo'>系统:
                                    <span class="userlogininfo">{{testSuite.system}}</span>
                                </div>
                            </div>
                            <div class="title">
                                <span class="suitesize">场景集合</span>
                            </div>
                            <el-table :data="testSuite.data" border>
                                <el-table-column type="index" min-width="10%"></el-table-column>
                                <!-- <el-table-column prop="id" label="序号" size="small" min-width="10%"></el-table-column> -->
                                <el-table-column prop="TestSuite" label="场景名称" min-width="30%"></el-table-column>
                                <el-table-column prop="TestSuiteDesc" size="small" label="场景描述" min-width="30%"></el-table-column>
                                <el-table-column label="操作" min-width="30%">
                                    <template scope="scope">
                                        <el-button type="primary" size="small" @click="addtestscene(scope.row)">组合</el-button>
                                        <el-button type="primary" size="small" @click="addSuiteList(scope.row)">增加</el-button>
                                        <el-button type="primary" size="small" @click="showTestSuiteDetail(scope.row)">展示</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
                            <div class="title">
                                <span class="suitesize">场景用例展示集合</span>
                            </div>
                            <el-table :data="testSuiteDetails.TestSuiteData" border>
                                <el-table-column type="index" min-width="10%"></el-table-column>
                                <el-table-column prop="id" label="序号" sortable size="small" min-width="10%"></el-table-column>
                                <el-table-column prop="name" label="接口名称" sortable min-width="30%"></el-table-column>
                                <el-table-column prop="desc" size="small" label="场景描述" min-width="30%"></el-table-column>
                                <el-table-column label="操作" min-width="30%">
                                    <template scope="scope">
                                        <el-button type="primary" size="small" @click="deltestcase(scope.$index, scope.row)">删除</el-button>
                                        <el-button type="primary" size="small" @click="showTestDetail1(scope.row)">展示</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
    
                        </el-tabs>
                    </el-col>
                     
                    <el-col id="order-list" :span="12" v-show="show2Right">
                        <div class="often-goods">
                            <div class="title">主键定位
                                <button class="savebackend">同步后台</button>
                                <button class="save" @click="save">保存当前</button>
                            </div>
                            <div class="often-goods-list">
                                <ul>
                                    <li>
                                        <i>id: </i>
                                        <input class="o-price" disabled=true v-model="often2Goods.id" />
                                    </li>
                                    <li>
                                        <i>name: </i>
                                        <input class="o-price" disabled=true v-model="often2Goods.name" />
                                    </li>
                                    <li>
                                        <i>desc: </i>
                                        <input class="o-price " v-model="often2Goods.desc" />
                                    </li>
                                </ul>
                            </div>
                            <div class="title">输入值</div>
                            <div class="often-goods-list">
                                <ul>
                                    <li v-for="(key,value) in often2Goods.input">
                                        <i>{{value}}:
                                            <input class="o-price" v-model="often2Goods.input[value]
                                                    "></input>
                                        </i>
    
                                    </li>
                                </ul>
                            </div>
                            <div class="title">输出结果</div>
                            <div class="often-goods-list">
                                <ul>
                                    <li v-for="(key,value) in often2Goods.expectResult">
                                        <i>{{value}}:
                                            <input class="o-price" v-model="often2Goods.expectResult[value]" /> </i>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import Vue from 'vue'
import collapse from '../common/collapse.vue'
export default {
    name: 'Pos',
    data() {
        return {
            testProgress: false,
            dialogFormVisible: false,
            dialogTableVisible: false,

            form: {
                TestSuite: '',
                TestSuiteDesc: '',
                id: '',
                TestSuiteData: ''
            },
            formLabelWidth: '120px',
            input: '',
            testscene: [],
            index: 0,
            showRight: false,
            show2Right: false,
            testSuiteClick: [],
            testSuiteDetails: [],
            testSuite:
            {
                "name": "场景用例集合",
                "spi": "tradespi",
                "system": "NTSStock",
                "index": "1",
                "data": [
                    {
                        "TestSuite": "TestSuite场景1",
                        "id": 1,
                        "TestSuiteDesc": "TestSuite场景1的描述",
                        "TestSuiteData": [
                            {
                                "id": 1,
                                "name": "qryInstrumentXml",
                                "desc": "场景1",
                                "input": {
                                    "exchangeID": "SSE",
                                    "instrumentID": "11001595"
                                },
                                "expectResult": {
                                    "volumeMultiple": 0,
                                    "trading": false,
                                    "productClass": "",
                                    "returnqryInstrument": -1,
                                    "execPrice": 0,
                                    "unitMargin": 0,
                                    "priceTick": 0
                                }
                            },
                            {
                                "id": 2,
                                "name": "qryInstrumentXml",
                                "desc": "场景2",
                                "input": {
                                    "exchangeID": "SSE",
                                    "instrumentID": "11001596"
                                },
                                "expectResult": {
                                    "volumeMultiple": 0,
                                    "trading": false,
                                    "productClass": "",
                                    "returnqryInstrument": -1,
                                    "execPrice": 0,
                                    "unitMargin": 0,
                                    "priceTick": 0
                                }
                            },
                            {
                                "id": 3,
                                "name": "qryTradingAccountXml",
                                "desc": "场景3",
                                "input": {
                                    "brokerID": "2016",
                                    "investorID": "1300",
                                    "comboID": "000",
                                    "assetNo": "2066"
                                },
                                "expectResult": {
                                    "frozenMargin": 0,
                                    "cashIn": 0,
                                    "frozenCommission": 0,
                                    "available": 0,
                                    "investorID": "",
                                    "preCredit": 0,
                                    "preDeposit": 0,
                                    "preBalance": 0,
                                    "currMargin": 0,
                                    "preMargin": 0,
                                    "frozenCash": 0,
                                    "settleMargin": 0,
                                    "closeProfit": 0,
                                    "positionProfit": 0,
                                    "preMortgage": 0,
                                    "balance": 0,
                                    "withdrawQuota": 0,
                                    "reserve": 0,
                                    "deposit": 0,
                                    "commission": 0,
                                    "credit": 0,
                                    "return": 0,
                                    "withdraw": 0
                                }
                            }
                        ]
                    },
                    {
                        "TestSuite": "TestSuite场景2",
                        "id": 2,
                        "TestSuiteDesc": "TestSuite场景2的描述",
                        "TestSuiteData": [
                            {
                                "id": 1,
                                "name": "qryInstrumentXml",
                                "desc": "场景1",
                                "input": {
                                    "exchangeID": "SSE",
                                    "instrumentID": "11001595"
                                },
                                "expectResult": {
                                    "volumeMultiple": 0,
                                    "trading": false,
                                    "productClass": "",
                                    "returnqryInstrument": -1,
                                    "execPrice": 0,
                                    "unitMargin": 0,
                                    "priceTick": 0
                                }
                            },
                            {
                                "id": 2,
                                "name": "qryInstrumentXml",
                                "desc": "场景2",
                                "input": {
                                    "exchangeID": "SSE",
                                    "instrumentID": "11001596"
                                },
                                "expectResult": {
                                    "volumeMultiple": 0,
                                    "trading": false,
                                    "productClass": "",
                                    "returnqryInstrument": -1,
                                    "execPrice": 0,
                                    "unitMargin": 0,
                                    "priceTick": 0
                                }
                            },
                            {
                                "id": 3,
                                "name": "qryTradingAccountXml",
                                "desc": "场景3",
                                "input": {
                                    "brokerID": "2016",
                                    "investorID": "1300",
                                    "comboID": "000",
                                    "assetNo": "2066"
                                },
                                "expectResult": {
                                    "frozenMargin": 0,
                                    "cashIn": 0,
                                    "frozenCommission": 0,
                                    "available": 0,
                                    "investorID": "",
                                    "preCredit": 0,
                                    "preDeposit": 0,
                                    "preBalance": 0,
                                    "currMargin": 0,
                                    "preMargin": 0,
                                    "frozenCash": 0,
                                    "settleMargin": 0,
                                    "closeProfit": 0,
                                    "positionProfit": 0,
                                    "preMortgage": 0,
                                    "balance": 0,
                                    "withdrawQuota": 0,
                                    "reserve": 0,
                                    "deposit": 0,
                                    "commission": 0,
                                    "credit": 0,
                                    "return": 0,
                                    "withdraw": 0
                                }
                            },
                            {
                                "id": 4,
                                "name": "qryTradingAccountXml",
                                "desc": "场景4",
                                "input": {
                                    "investorID": "1300",
                                    "comboID": "333",
                                    "assetNo": "2066"
                                },
                                "expectResult": {
                                    "frozenMargin": 0,
                                    "cashIn": 0,
                                    "frozenCommission": 0,
                                    "available": 0,
                                    "investorID": "",
                                    "preCredit": 0,
                                    "preDeposit": 0,
                                    "preBalance": 0,
                                    "currMargin": 0,
                                    "preMargin": 0,
                                    "frozenCash": 0,
                                    "settleMargin": 0,
                                    "closeProfit": 0,
                                    "positionProfit": 0,
                                    "preMortgage": 0,
                                    "balance": 0,
                                    "withdrawQuota": 0,
                                    "reserve": 0,
                                    "deposit": 0,
                                    "commission": 0,
                                    "credit": 0,
                                    "return": 0,
                                    "withdraw": 0
                                }
                            }
                        ]
                    },
                    {
                        "TestSuite": "TestSuite场景3",
                        "id": 3,
                        "TestSuiteDesc": "TestSuite场景3的描述",
                        "TestSuiteData": [
                            {
                                "id": 5,
                                "name": "qryPostionXml",
                                "desc": "场景5",
                                "input": {
                                    "brokerID": "2016",
                                    "instrumentID": "11001595",
                                    "investorID": "1300",
                                    "comboID": "000"
                                },
                                "expectResult": {
                                    "longFrozenAmount": 0,
                                    "closeYdAmount": 0,
                                    "longFrozen": 0,
                                    "closeAmount": 0,
                                    "todayPositionCost": 0,
                                    "ydPosition": 0,
                                    "preSettlementPrice": 0,
                                    "preMargin": 0,
                                    "ydPositionCost": 0,
                                    "closeProfit": 0,
                                    "positionProfit": 0,
                                    "positionCost": 0,
                                    "closeYdVolume": 0,
                                    "tradingDay": 0,
                                    "closeVolume": 0,
                                    "openVolume": 0,
                                    "commission": 0,
                                    "todayPosition": 0,
                                    "useMargin": 0,
                                    "frozenMargin": 0,
                                    "frozenCommission": 0,
                                    "availablePosition": 0,
                                    "shortFrozenAmount": 0,
                                    "posiDirection": "",
                                    "frozenCash": 0,
                                    "openAmount": 0,
                                    "hedgeFlag": "",
                                    "shortFrozen": 0,
                                    "settlementPrice": 0,
                                    "position": "164",
                                    "return": 0
                                }
                            },
                            {
                                "id": 6,
                                "name": "qryPostionXml",
                                "desc": "场景6",
                                "input": {
                                    "brokerID": "2016",
                                    "instrumentID": "11001596",
                                    "investorID": "1300",
                                    "comboID": "000"
                                },
                                "expectResult": {
                                    "longFrozenAmount": 0,
                                    "closeYdAmount": 0,
                                    "longFrozen": 0,
                                    "closeAmount": 0,
                                    "todayPositionCost": 0,
                                    "ydPosition": 0,
                                    "preSettlementPrice": 0,
                                    "preMargin": 0,
                                    "ydPositionCost": 0,
                                    "closeProfit": 0,
                                    "positionProfit": 0,
                                    "positionCost": 0,
                                    "closeYdVolume": 0,
                                    "tradingDay": 0,
                                    "closeVolume": 0,
                                    "openVolume": 0,
                                    "commission": 0,
                                    "todayPosition": 0,
                                    "useMargin": 0,
                                    "frozenMargin": 0,
                                    "frozenCommission": 0,
                                    "availablePosition": 0,
                                    "shortFrozenAmount": 0,
                                    "posiDirection": "",
                                    "frozenCash": 0,
                                    "openAmount": 0,
                                    "hedgeFlag": "",
                                    "shortFrozen": 0,
                                    "settlementPrice": 0,
                                    "position": "0.0",
                                    "return": 0
                                }
                            },
                            {
                                "id": 7,
                                "name": "qryComboXml",
                                "desc": "场景7",
                                "input": {
                                    "brokerID": "2016",
                                    "investorID": "1300",
                                    "comboID": "000"
                                },
                                "expectResult": {
                                    "comboName": "default_combo",
                                    "comboID": "000",
                                    "return": 0
                                }
                            },
                            {
                                "id": 8,
                                "name": "qryComboXml",
                                "desc": "场景8",
                                "input": {
                                    "brokerID": "2016",
                                    "investorID": "1301"
                                },
                                "expectResult": {
                                    "comboName": "",
                                    "return": 0
                                }
                            },
                            {
                                "id": 9,
                                "name": "qryOrderXml",
                                "desc": "场景9",
                                "input": {
                                    "exchangeID": "SSE",
                                    "orderLocalID": "OrderLocalID",
                                    "brokerID": "2016",
                                    "instrumentID": "11001595",
                                    "investorID": "1300",
                                    "comboID": "000"
                                },
                                "expectResult": {
                                    "volume": 0,
                                    "thirdReff": 0,
                                    "tradeAmount": 0,
                                    "brokerID": "2016",
                                    "sequenceNo": 0,
                                    "returnqryInstrument": 0,
                                    "orderRef": 0,
                                    "brokerOrderSeq": 0
                                }
                            }
                        ]
                    },
                    {
                        "TestSuite": "TestSuite场景4",
                        "id": 4,
                        "TestSuiteDesc": "TestSuite场景4的描述",
                        "TestSuiteData": [
                            {
                                "id": 10,
                                "name": "qryOrderXml",
                                "desc": "场景10",
                                "input": {
                                    "exchangeID": "SSE",
                                    "orderLocalID": "unExistID",
                                    "brokerID": "2016",
                                    "instrumentID": "11001595",
                                    "investorID": "1300",
                                    "comboID": "000"
                                },
                                "expectResult": {
                                    "volume": 0,
                                    "thirdReff": 0,
                                    "tradeAmount": 0,
                                    "brokerID": "",
                                    "sequenceNo": 0,
                                    "returnqryInstrument": 0,
                                    "orderRef": 0,
                                    "brokerOrderSeq": 0
                                }
                            },
                            {
                                "id": 11,
                                "name": "qryOrderXml",
                                "desc": "场景11",
                                "input": {
                                    "exchangeID": "SSE",
                                    "brokerID": "2016",
                                    "instrumentID": "11001595",
                                    "investorID": "1300",
                                    "comboID": "000"
                                },
                                "expectResult": {
                                    "volume": 0,
                                    "thirdReff": 0,
                                    "tradeAmount": 0,
                                    "brokerID": "2016",
                                    "sequenceNo": 0,
                                    "returnqryInstrument": 0,
                                    "orderRef": 0,
                                    "brokerOrderSeq": 0
                                }
                            },
                            {
                                "id": 12,
                                "name": "sendOrderxml",
                                "desc": "场景12",
                                "input": {
                                    "orderPriceType": "2",
                                    "thirdReff": 2042,
                                    "brokerID": "2016",
                                    "limitPrice": 15.06,
                                    "instrumentID": "600000",
                                    "investorID": "0301",
                                    "comboID": "000",
                                    "volumeTotalOriginal": 100,
                                    "exchangeID": "SSE",
                                    "combOffsetFlag": "0",
                                    "orderRef": 333,
                                    "minVolume": 1,
                                    "combHedgeFlag": "1",
                                    "volumeCondition": "1",
                                    "contingentCondition": "1",
                                    "timeCondition": "3",
                                    "direction": "0"
                                },
                                "expectResult": {
                                    "volume": 0,
                                    "thirdReff": 0,
                                    "tradeAmount": 0,
                                    "brokerID": "2016",
                                    "sequenceNo": 0,
                                    "orderRef": 0,
                                    "brokerOrderSeq": 0,
                                    "return": 0
                                }
                            },
                            {
                                "id": 13,
                                "name": "sendOrderxml",
                                "desc": "场景13",
                                "input": {
                                    "orderPriceType": "2",
                                    "thirdReff": 2042,
                                    "brokerID": "2016",
                                    "limitPrice": 15.06,
                                    "instrumentID": "600000",
                                    "investorID": "0301",
                                    "comboID": "000",
                                    "volumeTotalOriginal": 100,
                                    "exchangeID": "SSE",
                                    "combOffsetFlag": "0",
                                    "orderRef": 444,
                                    "minVolume": 1,
                                    "combHedgeFlag": "1",
                                    "volumeCondition": "1",
                                    "contingentCondition": "1",
                                    "timeCondition": "3",
                                    "direction": "0"
                                },
                                "expectResult": {
                                    "volume": 0,
                                    "thirdReff": 0,
                                    "tradeAmount": 0,
                                    "brokerID": "2016",
                                    "sequenceNo": 0,
                                    "orderRef": 0,
                                    "brokerOrderSeq": 0,
                                    "return": 0
                                }
                            }
                        ]
                    }
                ]


            },
            testcasedata: [],
            fold: false,
            mydata: [],
            olddata: [
                {
                    'password': '123456',
                    'userID': '0301',
                    'brokerID': '2016',
                    'spi': 'tradespi',
                    'system': 'NTSStock',
                    'testdata':
                    [
                        {
                            id: 1,
                            name: 'qryInstrumentXml',
                            desc: '场景1',
                            'input': {
                                'exchangeID': 'SSE',
                                'instrumentID': '11001595'
                            },
                            'expectResult': {
                                'volumeMultiple': 0,
                                'trading': false,
                                'productClass': '',
                                'returnqryInstrument': -1,
                                'execPrice': 0,
                                'unitMargin': 0,
                                'priceTick': 0
                            }
                        },
                        {
                            id: 2,
                            name: 'qryInstrumentXml',
                            desc: '场景2',
                            'input': {
                                'exchangeID': 'SSE',
                                'instrumentID': '11001596'
                            },
                            'expectResult': {
                                'volumeMultiple': 0,
                                'trading': false,
                                'productClass': '',
                                'returnqryInstrument': -1,
                                'execPrice': 0,
                                'unitMargin': 0,
                                'priceTick': 0
                            }
                        },
                        {
                            id: 3,
                            name: 'qryTradingAccountXml',
                            desc: '场景3',
                            'input': {
                                'brokerID': '2016',
                                'investorID': '1300',
                                'comboID': '000',
                                'assetNo': '2066'
                            },
                            'expectResult': {
                                'frozenMargin': 0,
                                'cashIn': 0,
                                'frozenCommission': 0,
                                'available': 0,
                                'investorID': '',
                                'preCredit': 0,
                                'preDeposit': 0,
                                'preBalance': 0,
                                'currMargin': 0,
                                'preMargin': 0,
                                'frozenCash': 0,
                                'settleMargin': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'preMortgage': 0,
                                'balance': 0,
                                'withdrawQuota': 0,
                                'reserve': 0,
                                'deposit': 0,
                                'commission': 0,
                                'credit': 0,
                                'return': 0,
                                'withdraw': 0
                            }
                        },
                        {
                            id: 4,
                            name: 'qryTradingAccountXml',
                            desc: '场景4',
                            'input': {
                                'investorID': '1300',
                                'comboID': '333',
                                'assetNo': '2066'
                            },
                            'expectResult': {
                                'frozenMargin': 0,
                                'cashIn': 0,
                                'frozenCommission': 0,
                                'available': 0,
                                'investorID': '',
                                'preCredit': 0,
                                'preDeposit': 0,
                                'preBalance': 0,
                                'currMargin': 0,
                                'preMargin': 0,
                                'frozenCash': 0,
                                'settleMargin': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'preMortgage': 0,
                                'balance': 0,
                                'withdrawQuota': 0,
                                'reserve': 0,
                                'deposit': 0,
                                'commission': 0,
                                'credit': 0,
                                'return': 0,
                                'withdraw': 0
                            }
                        },
                        {
                            id: 5,
                            name: 'qryPostionXml',
                            desc: '场景5',
                            'input': {
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'longFrozenAmount': 0,
                                'closeYdAmount': 0,
                                'longFrozen': 0,
                                'closeAmount': 0,
                                'todayPositionCost': 0,
                                'ydPosition': 0,
                                'preSettlementPrice': 0,
                                'preMargin': 0,
                                'ydPositionCost': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'positionCost': 0,
                                'closeYdVolume': 0,
                                'tradingDay': 0,
                                'closeVolume': 0,
                                'openVolume': 0,
                                'commission': 0,
                                'todayPosition': 0,
                                'useMargin': 0,
                                'frozenMargin': 0,
                                'frozenCommission': 0,
                                'availablePosition': 0,
                                'shortFrozenAmount': 0,
                                'posiDirection': '',
                                'frozenCash': 0,
                                'openAmount': 0,
                                'hedgeFlag': '',
                                'shortFrozen': 0,
                                'settlementPrice': 0,
                                'position': '164',
                                'return': 0
                            }
                        },
                        {
                            id: 6,
                            name: 'qryPostionXml',
                            desc: '场景6',
                            'input': {
                                'brokerID': '2016',
                                'instrumentID': '11001596',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'longFrozenAmount': 0,
                                'closeYdAmount': 0,
                                'longFrozen': 0,
                                'closeAmount': 0,
                                'todayPositionCost': 0,
                                'ydPosition': 0,
                                'preSettlementPrice': 0,
                                'preMargin': 0,
                                'ydPositionCost': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'positionCost': 0,
                                'closeYdVolume': 0,
                                'tradingDay': 0,
                                'closeVolume': 0,
                                'openVolume': 0,
                                'commission': 0,
                                'todayPosition': 0,
                                'useMargin': 0,
                                'frozenMargin': 0,
                                'frozenCommission': 0,
                                'availablePosition': 0,
                                'shortFrozenAmount': 0,
                                'posiDirection': '',
                                'frozenCash': 0,
                                'openAmount': 0,
                                'hedgeFlag': '',
                                'shortFrozen': 0,
                                'settlementPrice': 0,
                                'position': '0.0',
                                'return': 0
                            }
                        },
                        {
                            id: 7,
                            name: 'qryComboXml',
                            desc: '场景7',
                            'input': {
                                'brokerID': '2016',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'comboName': 'default_combo',
                                'comboID': '000',
                                'return': 0
                            }
                        },
                        {
                            id: 8,
                            name: 'qryComboXml',
                            desc: '场景8',
                            'input': {
                                'brokerID': '2016',
                                'investorID': '1301'
                            },
                            'expectResult': {
                                'comboName': '',
                                'return': 0
                            }
                        },
                        {
                            id: 9,
                            name: 'qryOrderXml',
                            desc: '场景9',
                            'input': {
                                'exchangeID': 'SSE',
                                'orderLocalID': 'OrderLocalID',
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'returnqryInstrument': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0
                            }
                        },
                        {
                            id: 10,
                            name: 'qryOrderXml',
                            desc: '场景10',
                            'input': {
                                'exchangeID': 'SSE',
                                'orderLocalID': 'unExistID',
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '',
                                'sequenceNo': 0,
                                'returnqryInstrument': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0
                            }
                        },
                        {
                            id: 11,
                            name: 'qryOrderXml',
                            desc: '场景11',
                            'input': {
                                'exchangeID': 'SSE',
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'returnqryInstrument': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0
                            }
                        },
                        {
                            id: 12,
                            name: 'sendOrderxml',
                            desc: '场景12',
                            'input': {
                                'orderPriceType': '2',
                                'thirdReff': 2042,
                                'brokerID': '2016',
                                'limitPrice': 15.06,
                                'instrumentID': '600000',
                                'investorID': '0301',
                                'comboID': '000',
                                'volumeTotalOriginal': 100,
                                'exchangeID': 'SSE',
                                'combOffsetFlag': '0',
                                'orderRef': 333,
                                'minVolume': 1,
                                'combHedgeFlag': '1',
                                'volumeCondition': '1',
                                'contingentCondition': '1',
                                'timeCondition': '3',
                                'direction': '0'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0,
                                'return': 0
                            }
                        },
                        {
                            id: 13,
                            name: 'sendOrderxml',
                            desc: '场景13',
                            'input': {
                                'orderPriceType': '2',
                                'thirdReff': 2042,
                                'brokerID': '2016',
                                'limitPrice': 15.06,
                                'instrumentID': '600000',
                                'investorID': '0301',
                                'comboID': '000',
                                'volumeTotalOriginal': 100,
                                'exchangeID': 'SSE',
                                'combOffsetFlag': '0',
                                'orderRef': 444,
                                'minVolume': 1,
                                'combHedgeFlag': '1',
                                'volumeCondition': '1',
                                'contingentCondition': '1',
                                'timeCondition': '3',
                                'direction': '0'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0,
                                'return': 0
                            }
                        },
                    ]
                }

            ],
            mydata1: [
                {
                    'password': '123456',
                    'userID': '0301',
                    'brokerID': '2016',
                    'spi': 'tradespi',
                    'system': 'NTSStock',
                    'testdata':
                    [
                        {
                            id: 1,
                            name: 'qryInstrumentXml',
                            desc: '场景1',
                            'input': {
                                'exchangeID': 'SSE',
                                'instrumentID': '11001595'
                            },
                            'expectResult': {
                                'volumeMultiple': 0,
                                'trading': false,
                                'productClass': '',
                                'returnqryInstrument': -1,
                                'execPrice': 0,
                                'unitMargin': 0,
                                'priceTick': 0
                            }
                        },
                        {
                            id: 2,
                            name: 'qryInstrumentXml',
                            desc: '场景2',
                            'input': {
                                'exchangeID': 'SSE',
                                'instrumentID': '11001596'
                            },
                            'expectResult': {
                                'volumeMultiple': 0,
                                'trading': false,
                                'productClass': '',
                                'returnqryInstrument': -1,
                                'execPrice': 0,
                                'unitMargin': 0,
                                'priceTick': 0
                            }
                        },
                        {
                            id: 3,
                            name: 'qryTradingAccountXml',
                            desc: '场景3',
                            'input': {
                                'brokerID': '2016',
                                'investorID': '1300',
                                'comboID': '000',
                                'assetNo': '2066'
                            },
                            'expectResult': {
                                'frozenMargin': 0,
                                'cashIn': 0,
                                'frozenCommission': 0,
                                'available': 0,
                                'investorID': '',
                                'preCredit': 0,
                                'preDeposit': 0,
                                'preBalance': 0,
                                'currMargin': 0,
                                'preMargin': 0,
                                'frozenCash': 0,
                                'settleMargin': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'preMortgage': 0,
                                'balance': 0,
                                'withdrawQuota': 0,
                                'reserve': 0,
                                'deposit': 0,
                                'commission': 0,
                                'credit': 0,
                                'return': 0,
                                'withdraw': 0
                            }
                        },
                        {
                            id: 4,
                            name: 'qryTradingAccountXml',
                            desc: '场景4',
                            'input': {
                                'investorID': '1300',
                                'comboID': '333',
                                'assetNo': '2066'
                            },
                            'expectResult': {
                                'frozenMargin': 0,
                                'cashIn': 0,
                                'frozenCommission': 0,
                                'available': 0,
                                'investorID': '',
                                'preCredit': 0,
                                'preDeposit': 0,
                                'preBalance': 0,
                                'currMargin': 0,
                                'preMargin': 0,
                                'frozenCash': 0,
                                'settleMargin': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'preMortgage': 0,
                                'balance': 0,
                                'withdrawQuota': 0,
                                'reserve': 0,
                                'deposit': 0,
                                'commission': 0,
                                'credit': 0,
                                'return': 0,
                                'withdraw': 0
                            }
                        },
                        {
                            id: 5,
                            name: 'qryPostionXml',
                            desc: '场景5',
                            'input': {
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'longFrozenAmount': 0,
                                'closeYdAmount': 0,
                                'longFrozen': 0,
                                'closeAmount': 0,
                                'todayPositionCost': 0,
                                'ydPosition': 0,
                                'preSettlementPrice': 0,
                                'preMargin': 0,
                                'ydPositionCost': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'positionCost': 0,
                                'closeYdVolume': 0,
                                'tradingDay': 0,
                                'closeVolume': 0,
                                'openVolume': 0,
                                'commission': 0,
                                'todayPosition': 0,
                                'useMargin': 0,
                                'frozenMargin': 0,
                                'frozenCommission': 0,
                                'availablePosition': 0,
                                'shortFrozenAmount': 0,
                                'posiDirection': '',
                                'frozenCash': 0,
                                'openAmount': 0,
                                'hedgeFlag': '',
                                'shortFrozen': 0,
                                'settlementPrice': 0,
                                'position': '164',
                                'return': 0
                            }
                        },
                        {
                            id: 6,
                            name: 'qryPostionXml',
                            desc: '场景6',
                            'input': {
                                'brokerID': '2016',
                                'instrumentID': '11001596',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'longFrozenAmount': 0,
                                'closeYdAmount': 0,
                                'longFrozen': 0,
                                'closeAmount': 0,
                                'todayPositionCost': 0,
                                'ydPosition': 0,
                                'preSettlementPrice': 0,
                                'preMargin': 0,
                                'ydPositionCost': 0,
                                'closeProfit': 0,
                                'positionProfit': 0,
                                'positionCost': 0,
                                'closeYdVolume': 0,
                                'tradingDay': 0,
                                'closeVolume': 0,
                                'openVolume': 0,
                                'commission': 0,
                                'todayPosition': 0,
                                'useMargin': 0,
                                'frozenMargin': 0,
                                'frozenCommission': 0,
                                'availablePosition': 0,
                                'shortFrozenAmount': 0,
                                'posiDirection': '',
                                'frozenCash': 0,
                                'openAmount': 0,
                                'hedgeFlag': '',
                                'shortFrozen': 0,
                                'settlementPrice': 0,
                                'position': '0.0',
                                'return': 0
                            }
                        },
                        {
                            id: 7,
                            name: 'qryComboXml',
                            desc: '场景7',
                            'input': {
                                'brokerID': '2016',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'comboName': 'default_combo',
                                'comboID': '000',
                                'return': 0
                            }
                        },
                        {
                            id: 8,
                            name: 'qryComboXml',
                            desc: '场景8',
                            'input': {
                                'brokerID': '2016',
                                'investorID': '1301'
                            },
                            'expectResult': {
                                'comboName': '',
                                'return': 0
                            }
                        },
                        {
                            id: 9,
                            name: 'qryOrderXml',
                            desc: '场景9',
                            'input': {
                                'exchangeID': 'SSE',
                                'orderLocalID': 'OrderLocalID',
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'returnqryInstrument': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0
                            }
                        },
                        {
                            id: 10,
                            name: 'qryOrderXml',
                            desc: '场景10',
                            'input': {
                                'exchangeID': 'SSE',
                                'orderLocalID': 'unExistID',
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '',
                                'sequenceNo': 0,
                                'returnqryInstrument': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0
                            }
                        },
                        {
                            id: 11,
                            name: 'qryOrderXml',
                            desc: '场景11',
                            'input': {
                                'exchangeID': 'SSE',
                                'brokerID': '2016',
                                'instrumentID': '11001595',
                                'investorID': '1300',
                                'comboID': '000'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'returnqryInstrument': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0
                            }
                        },
                        {
                            id: 12,
                            name: 'sendOrderxml',
                            desc: '场景12',
                            'input': {
                                'orderPriceType': '2',
                                'thirdReff': 2042,
                                'brokerID': '2016',
                                'limitPrice': 15.06,
                                'instrumentID': '600000',
                                'investorID': '0301',
                                'comboID': '000',
                                'volumeTotalOriginal': 100,
                                'exchangeID': 'SSE',
                                'combOffsetFlag': '0',
                                'orderRef': 333,
                                'minVolume': 1,
                                'combHedgeFlag': '1',
                                'volumeCondition': '1',
                                'contingentCondition': '1',
                                'timeCondition': '3',
                                'direction': '0'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0,
                                'return': 0
                            }
                        },
                        {
                            id: 13,
                            name: 'sendOrderxml',
                            desc: '场景13',
                            'input': {
                                'orderPriceType': '2',
                                'thirdReff': 2042,
                                'brokerID': '2016',
                                'limitPrice': 15.06,
                                'instrumentID': '600000',
                                'investorID': '0301',
                                'comboID': '000',
                                'volumeTotalOriginal': 100,
                                'exchangeID': 'SSE',
                                'combOffsetFlag': '0',
                                'orderRef': 444,
                                'minVolume': 1,
                                'combHedgeFlag': '1',
                                'volumeCondition': '1',
                                'contingentCondition': '1',
                                'timeCondition': '3',
                                'direction': '0'
                            },
                            'expectResult': {
                                'volume': 0,
                                'thirdReff': 0,
                                'tradeAmount': 0,
                                'brokerID': '2016',
                                'sequenceNo': 0,
                                'orderRef': 0,
                                'brokerOrderSeq': 0,
                                'return': 0
                            }
                        },
                    ]
                }

            ],
            tableData: [],
            totalMoney: 0,
            totalCount: 0,
            type0Goods: [],
            type1Goods: [],
            type2Goods: [],
            type3Goods: [],
            oftenGoods: [],
            often2Goods: [],
            columns: [
                {
                    text: '姓名',
                    dataIndex: 'name'
                },
                {
                    text: '年龄',
                    dataIndex: 'age'
                },
                {
                    text: '性别',
                    dataIndex: 'sex'
                }
            ],
            dataSource: [
                {
                    id: 1,
                    parentId: 0,
                    name: '测试1',
                    age: 18,
                    sex: '男',
                    children: [
                        {
                            id: 2,
                            parentId: 1,
                            name: '测试2',
                            age: 22,
                            sex: '男'
                        }
                    ]
                },
                {
                    id: 3,
                    parentId: 0,
                    name: '测试3',
                    age: 23,
                    sex: '女',
                    children: [
                        {
                            id: 4,
                            parentId: 3,
                            name: '测试4',
                            age: 22,
                            sex: '男'
                        },
                        {
                            id: 5,
                            parentId: 3,
                            name: '测试5',
                            age: 25,
                            sex: '男'
                        },
                        {
                            id: 6,
                            parentId: 3,
                            name: '测试6',
                            age: 26,
                            sex: '女',
                            children: [
                                {
                                    id: 7,
                                    parentId: 6,
                                    name: '测试7',
                                    age: 27,
                                    sex: '男'
                                }
                            ]
                        }
                    ]
                },
                {
                    id: 18,
                    parentId: 0,
                    name: '测试8',
                    age: 18,
                    sex: '男'
                }
            ]

        }
    },
    created() {
        // axios.get('http://jspang.com/DemoApi/oftenGoods.php').then(reponse => {
        //     this.oftenGoods = reponse.data
        // })
        //     .catch(error => {
        //         console.log(error)
        //         alert('网络错误')
        //     })
        axios.get('http://localhost:8081/myapp/arequestAjax1', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
            this.mydata = response.data
            console.log(this.mydata)
        })
            .catch(error => {
                console.log(error)
                alert('网络错误')
            })
        axios.get('http://jspang.com/DemoApi/typeGoods.php').then(reponse => {
            this.type0Goods = reponse.data[0]
            this.type1Goods = reponse.data[1]
            this.type2Goods = reponse.data[2]
            this.type3Goods = reponse.data[3]
        })
            .catch(error => {
                console.log(error)
                alert('网络错误')
            })
    },
    mounted: function () {
        var orderHeight = document.body.clientHeight
        document.getElementById('order-list').style.height = orderHeight + 'px'
    },
    methods: {
       handleClick(tab, event) {
       this.testProgress=false
      },
        runtestscene() {
           this.showRight=false
           this.show2Right=false
            this.testProgress = true
            this.$nextTick(function () {
                console.log("aaaaaaaaaaaaa")
            })
        },
        addnewTestsuite() {
            var testSuite = {
                "TestSuite": this.form.TestSuite,
                "TestSuiteDesc": this.form.TestSuiteDesc,
                "id": this.form.id, "TestSuiteData": []
            }
            this.testSuite.data.push(testSuite)
            this.$nextTick(function () {
                this.dialogFormVisible = false
            })


        },
        showTestSuiteDetail(testSuite) {
            this.testSuiteDetails = testSuite
        },
        //  savebackend () {
        //    this.olddata[0].testdata[this.oftenGoods.id]=JSON.parse(JSON.stringify(this.oftenGoods));
        //    console.log(this.olddata[0].testdata[this.oftenGoods.id].input.exchangeID)
        // },
        save() {
            let id = this.oftenGoods.id;
            //console.log(this.mydata1[0].testdata);
            for (let i = 0; i < this.mydata1[0].testdata.length; i++) {
                let test = this.mydata1[0].testdata[i];
                if (test.id == id) {
                    this.mydata1[0].testdata[i] = this.oftenGoods;
                }

            }

        },

        addSuiteList(testSuiteFocus) {
            this.testSuiteClick = testSuiteFocus
            this.testSuiteClick.TestSuiteData.push(this.testcasedata)

            this.$nextTick(function () {
                //  console.log(this.$el.textContent.olddata)

                this.testSuiteDetails = this.testSuiteClick
                //  window.location.reload();
            })
        },
        fresh() {
            alert('刷新后台数据成功');
            //this.mydata1 = this.olddata;
            //深度拷贝

            this.mydata1 = JSON.parse(JSON.stringify(this.olddata))
            this.oftenGoods = JSON.parse(JSON.stringify(this.olddata[0].testdata[this.oftenGoods.id]))
            this.$nextTick(function () {
                //  console.log(this.$el.textContent.olddata)
                // console.log(this.olddata[0].testdata[this.oftenGoods.id].input.exchangeID)
                //  window.location.reload();
            })

        },
        quit() {
            this.fold = false
            this.show2Right=false
              this.$nextTick(function () {
                //  console.log(this.$el.textContent.olddata)
                // console.log(this.olddata[0].testdata[this.oftenGoods.id].input.exchangeID)
                //  window.location.reload();
            })

        },
        addList(testCase) {

            this.testcasedata = testCase
            this.fold = true

        },
        update() {
            this.mydata1 = JSON.parse(JSON.stringify(this.olddata))
            this.$nextTick(function () {

            })
        },
        addOrderList(goods) {
            this.totalMoney = 0
            this.totalCount = 0
            let isHave = false
            for (let i = 0; i < this.tableData.length; i++) {
                if (this.tableData[i].goodsId === goods.goodsId) {
                    isHave = true
                }
            }
            if (isHave) {
                let arr = this.tableData.filter(o => o.goodsId === goods.goodsId)
                arr[0].count++
            } else {
                let newGoods = { goodsId: goods.goodsId, goodsName: goods.goodsName, price: goods.price, count: 1 }
                this.tableData.push(newGoods)
            }
            this.tableData.forEach((element) => {
                this.totalCount += element.count
                this.totalMoney = this.totalMoney + element.count * element.price
            })
        },
        showTestDetail(testCase) {
            this.showRight = true
            this.oftenGoods = testCase


        },
        showTestDetail1(testCase) {
            this.show2Right = true
            this.often2Goods = testCase


        },
        search(input) {
            let test = []
            this.mydata1[0].testdata.forEach(
                function (val, index, arr) {
                    if (arr[index].name.indexOf(input) !== -1) {

                        test.push(arr[index])
                    }

                }



            )
            console.log(test.length)
            this.mydata1[0].testdata = test
            this.$nextTick(function () {

            })

        },
        deltestdata11(index, testcase) {
            console.log(index)
            this.testscene.splice(index, 1)
            this.$nextTick(function () {

            })

        },

        deltestdata(index, testcase) {
            console.log(index)
            this.mydata1[0].testdata.splice(index, 1)
            this.$nextTick(function () {

            })

        },
        addtestscene(testsuite) {
            this.testscene.push(testsuite)
            this.$nextTick(function () {

            })

        },
        deltestcase(index, testcase) {
            let test11 = testcase
            this.index = index + 1
            console.log(test11)
            console.log(test11)
            this.testSuiteDetails.TestSuiteData.splice(this.index - 1, 1)
            if (this.testSuiteDetails.TestSuiteData.length === 0) {
                this.show2Right = false
            }
            if (test11.id != this.often2Goods.id) {
                return;
            } else {
                this.show2Right = false
            }

            this.$nextTick(function () {

            })

            //    this.testSuiteClick.TestSuiteData.$remove(testcase)
            //    this.$nextTick(function () {
            //         //  console.log(this.$el.textContent.olddata)

            //          this.testSuiteDetails= this.testSuiteClick
            //         //  window.location.reload();
            //     })
        },
        deleteAllGoods() {
            this.tableData = []
            this.totalMoney = 0
            this.totalCount = 0
        }
    },
    components: {
       collapse
    }
}
</script>
<style>
.pos-order {
    background-color: #F9FAFC;
    border-right: 1px solid #C0CCDA;
}

.div-btn {
    text-align: center;
    margin-top: 10px
}

.title {
    height: 20px;
    border-bottom: 5px solid #5599FF;
    background-color: #F9FAFC;
    padding: 10px;
}

.often-goods-list ul li {
    list-style: none;

    border: 1px solid #F9FAFC;
    padding: 10px;
    margin: 10px;
    background-color: #FFF;
}

.o-price {
    color: #5887FF
}

.goods-type {
    clear: both
}

.cooklist li {
    list-style: none;
    width: 23%;
    border: 1px solid #E5E9F2;
    height: auto;
    overflow: hidden;
    background-color: #fff;
    padding: 2px;
    float: left;
    margin: 2px;
}

.cookList li span {
    display: block;
    float: left;
}

.foodImg {
    width: 40%;
}

.foodName {
    font-size: 18px;
    padding-left: 10px;
    color: brown;
}

.foodPrice {
    font-size: 16px;
    padding-left: 10px;
    padding-top: 10px;
}

.totalDiv {
    text-align: center;
    background: #fff;
    padding: 10px;
    border-bottom: 1px solid #E5E9F2;
}

.userinfo {
    font-size: 16px;
    background-color: #fff;
    font-weight: 700;
    border-bottom: 1px solid #E5E9F2;
}

.userlogininfo {
    font-weight: 200;
    margin: 0 500 0 0;
    color: red;
    vertical-align: center;
}

.idsize {
    font-size: 10px;
    color: green;
}

.save {
    position: absolute;
    right: 50px;
}

.addtestList-wrapper {
    position: fixed;
    z-index: 100px;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background: rgba(7, 17, 27, 0.8);
    border-bottom: 1px solid #D3dce6;
    background-color: #F9FAFC;
}

.suitesize {
    font-size: 20px;
    font-weight: 700;
}

.filter {
    width: 100%;
    height: 50px;
    background: rgba(7, 17, 27, 0.8);
    border-bottom: 1px solid #D3dce6;
    background-color: #F9FAFC;
}

.input {
    width: 200px;
    padding: 10px 0 5px 20px;
}

.searchbutton {
    padding: 10px 10px 5px 10px
}

.dialog {
    position: absolute;
    right: 150px;
}
</style>
