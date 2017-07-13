<template>
  <div class="pos">
    <el-row>
     <el-col id="order-list" :span="12" class="pos-order">
      <el-tabs>
      
      <el-tab-pane label="测试用例集合">
      <div class="info">
      <div class="title">登陆信息
      <button @click="fresh">刷新</button></div>
      <div class='userinfo'>brokerId: <span class="userlogininfo">{{mydata1[0].brokerID}}</span></div>
      <div class='userinfo'>密码: <span class="userlogininfo">{{mydata1[0].password}}</span></div>
      <div class='userinfo'>spi: <span class="userlogininfo">{{mydata1[0].spi}}</span></div>
      <div class='userinfo'>系统: <span class="userlogininfo">{{mydata1[0].system}}</span></div>
      <div class='userinfo'>用户: <span class="userlogininfo">{{mydata1[0].userID}}</span></div>
      </div>
      <el-table  :data="mydata1[0].testdata" border >
      <el-table-column prop="id" label="序号" size="small" min-width="10%" ></el-table-column>
      <el-table-column prop="name" label="接口名称" min-width="30%"></el-table-column>
      <el-table-column prop="desc" size="small" label="场景描述" min-width="30%"></el-table-column>
      <el-table-column  label="操作" min-width="30%" >
      <template scope="scope">
      <el-button type="primary" size="small" @click="delSingleGoods(scope.row)">删除</el-button>
      <el-button type="primary" size="small" @click="addOrderList(scope.row)">增加</el-button>
      <el-button type="primary" size="small" @click="showTestDetail(scope.row)">展示</el-button>
      </template>
      </el-table-column>
      </el-table>
      </el-tab-pane>
      <el-tab-pane label="测试场景">
      <el-table  :data="tableData" border style="width:100%">
      <el-table-column prop="goodsName" label="商品名称"></el-table-column>
      <el-table-column prop="count" label="数量" width="70"></el-table-column>
      <el-table-column prop="price" label="金额" width="70"></el-table-column>
      <el-table-column  label="操作" width="100" fixed="right">
      <template scope="scope">
      <el-button type="text" size="small" @click="delSingleGoods(scope.row)">删除</el-button>
      <el-button type="text" size="small" @click="addOrderList(scope.row)">增加</el-button>
      </template>
      </el-table-column>
      </el-table>
      <div class="totalDiv">
      数量：{{totalCount}}   金额： {{totalMoney}}元
      </div>
      <div class="div-btn">
        <el-button type="warning">挂单</el-button>
        <el-button type="danger" @click="deleteAllGoods ()">删除</el-button>
        <el-button type="success">结账</el-button>

      </div>
      </el-tab-pane>
      <el-tab-pane label="测试结果">
      <span>aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</span>
      <el-table  :data="tableData" border style="width:100%">
      <el-table-column prop="id"label="商品名称"></el-table-column>
      <el-table-column prop="count" label="数量" width="70"></el-table-column>
      <el-table-column prop="price" label="金额" width="70"></el-table-column>
      <el-table-column  label="操作" width="100" fixed="right">
      <template scope="scope">
      <el-button type="text" size="small" @click="delSingleGoods(scope.row)">删除</el-button>
      <el-button type="text" size="small" @click="addOrderList(scope.row)">增加</el-button>
      </template>
      </el-table-column>
      </el-table>
      {{mydata.brokerID}}
      </el-tab-pane>
      </el-tabs>
 </el-col>
     <el-col id ="order-list" :span="12">
            <div class="often-goods">
              <div class="title">主键定位
              <button class="savebackend" >同步后台</button>
              <button class="save" @click="save">保存当前</button>
              </div>
              <div class="often-goods-list">
              <ul>
                <li>
                  <i >id:  </i>
                  <input class="o-price"  disabled=true v-model="oftenGoods.id"/>
                </li>
                <li>
                  <i >name:  </i>
                  <input class="o-price"  disabled=true v-model="oftenGoods.name"/>
                </li>
                <li>
                  <i >desc:  </i>
                  <input class="o-price " v-model="oftenGoods.desc"/>
                </li>
              </ul></div>
              <div class="title">输入值</div>
              <div class="often-goods-list">
              <ul>
                <li v-for="(key,value) in oftenGoods.input" >
                  <i >{{value}}:  <input class="o-price" v-model="oftenGoods.input[value]
"/>  </i>
                 
                </li>
              </ul></div>
              <div class="title">输出结果</div>
              <div class="often-goods-list">
              <ul>
                <li v-for="(key,value) in oftenGoods.expectResult" >
                  <i >{{value}}: <input class="o-price" v-model="oftenGoods.expectResult[value]"/>  </i>
                 
                </li>
              </ul></div>
            
            
            </div>
        <div class="goods-type">
        <el-tabs>
         <el-tab-pane label="汉堡">
         <div>
         <ul class="cooklist">
         <li v-for="item in type0Goods" @click="addOrderList(item)">
           <span class="foodImg"><img :src="item.goodsImg" width="100%"></span>
           <span class="foodName">{{item.goodsName}}</span>
           <span class="foodPrice">￥{{item.price}}元</span>
         </li>
         </ul>
         </div>
         </el-tab-pane>
         <el-tab-pane label="小食">
         <ul class="cooklist">
         <li v-for="item in type1Goods" @click="addOrderList(item)">
           <span class="foodImg"><img :src="item.goodsImg" width="100%"></span>
           <span class="foodName">{{item.goodsName}}</span>
           <span class="foodPrice">￥{{item.price}}元</span>
         </li>
          </ul>
         </el-tab-pane>
         <el-tab-pane label="饮料">
         <ul class="cooklist">
          <li v-for="item in type2Goods" @click="addOrderList(item)">
           <span class="foodImg"><img :src="item.goodsImg" width="100%"></span>
           <span class="foodName">{{item.goodsName}}</span>
           <span class="foodPrice">￥{{item.price}}元</span>
         </li>
          </ul>
         </el-tab-pane>
         <el-tab-pane label="套餐">
         <ul class="cooklist">
          <li v-for="item in type3Goods" @click="addOrderList(item)">
           <span class="foodImg"><img :src="item.goodsImg" width="100%"></span>
           <span class="foodName">{{item.goodsName}}</span>
           <span class="foodPrice">￥{{item.price}}元</span>
         </li>
          </ul>
          </el-tab-pane>
        </el-tabs>
        </div>
     </el-col>
    </el-row>
  </div>
</template>
<script>
  import axios from 'axios'
  import Vue from 'vue'
  export default {
    name: 'Pos',
    data () {
      return {
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
                          id:    1,
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
                              id:   2,
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
                          {    id: 3,
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
                          id:    1,
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
                              id:   2,
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
                          {    id: 3,
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
        oftenGoods: []
      }
    },
    created () {
      axios.get('http://jspang.com/DemoApi/oftenGoods.php').then(reponse => {
        this.oftenGoods = reponse.data
      })
      .catch(error => {
        console.log(error)
        alert('网络错误')
      })
      axios.get('http://localhost:8081/myapp/arequestAjax1', {headers: {'X-Requested-With': 'XMLHttpRequest'}}).then(response => {
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
    //  savebackend () {
     //    this.olddata[0].testdata[this.oftenGoods.id]=JSON.parse(JSON.stringify(this.oftenGoods));
     //    console.log(this.olddata[0].testdata[this.oftenGoods.id].input.exchangeID)
     // },
      save () {
        let id = this.oftenGoods.id;
        //console.log(this.mydata1[0].testdata);
        for( let i=0; i<this.mydata1[0].testdata.length; i++){
          let test = this.mydata1[0].testdata[i];
          if(test.id == id) {
           this.mydata1[0].testdata[i]=this.oftenGoods;
          }
          
        }
       
      },
      fresh () {
        alert('刷新后台数据成功');
        //this.mydata1 = this.olddata;
        //深度拷贝

        this.mydata1 = JSON.parse(JSON.stringify(this.olddata))
        this.oftenGoods = JSON.parse(JSON.stringify(this.olddata[0].testdata[this.oftenGoods.id]))
        this.$nextTick(function (){
    //  console.log(this.$el.textContent.olddata)
        console.log(this.olddata[0].testdata[this.oftenGoods.id].input.exchangeID)
    //  window.location.reload();
        })
        
      },
      addOrderList (goods) {
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
      showTestDetail (testCase) {
        this.oftenGoods=testCase
        console.log(testCase.input.exchangeID)

      } ,
      delSingleGoods (goods) {
        this.totalMoney = 0
        this.totalCount = 0
        this.tableData = this.tableData.filter(o => o.goodsId !== goods.goodsId)
        this.tableData.forEach((element) => {
          this.totalCount += element.count
          this.totalMoney = this.totalMoney + element.count * element.price
        })
      },
      deleteAllGoods () {
        this.tableData = []
        this.totalMoney = 0
        this.totalCount = 0
      }
    }
  }
</script>
<style>
  .pos-order{
    background-color: #F9FAFC;
    border-right: 1px solid #C0CCDA;
  }
  .div-btn{
    text-align: center;
    margin-top: 10px
  }
  .title{
    height: 20px;
    border-bottom: 1px solid #D3dce6;
    background-color: #F9FAFC;
    padding: 10px;
  }
  .often-goods-list ul li{
    list-style: none;
    
    border: 1px solid #F9FAFC;
    padding: 10px;
    margin: 10px;
    background-color: #FFF;
  }
  .o-price{
    color: #5887FF
  }
  .goods-type{
    clear: both
  }
  .cooklist li{
    list-style: none;
    width:23%;
    border:1px solid #E5E9F2;
    height: auto;
    overflow: hidden;
    background-color:#fff;
    padding: 2px;
    float:left;
    margin: 2px;

   }
   .cookList li span{
    display: block;
    float:left;
   }
   .foodImg{
    width: 40%;
   }
   .foodName{
    font-size: 18px;
    padding-left: 10px;
    color:brown;

   }
   .foodPrice{
    font-size: 16px;
    padding-left: 10px;
    padding-top:10px;
   }
   .totalDiv{
     text-align: center;
     background: #fff;
     padding: 10px;
     border-bottom: 1px solid #E5E9F2;
   }
   .userinfo{
      font-size: 16px;
      background-color:#fff;
      font-weight: 700;
      border-bottom: 1px solid #E5E9F2;
   }
   .userlogininfo{
     font-weight: 200;
     margin: 0 500 0 0;
     color: red;
     vertical-align: center;
   }
   .idsize{
     font-size: 10px;
     color: green;
   }
   .save{
     position: absolute;
     right: 50px;
   }
</style>
