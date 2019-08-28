<template>
  <div class="home container-fluid">
    <div class="language">
      <span @click="en_but">English</span>
      <span @click="sv_but">verige</span>
      <span @click="tw_but">臺灣</span>
    </div>
    <router-link class="container home-header" tag="div" to="./game"> 
    <!-- <img src="../../assets/images/gametwo.png" alt=""> -->
    <img src="../../assets/images/header.png" alt="">
    </router-link>
    <div @click.prevent="game_but"  class="container home-title" >
      <h3>{{ $t('index_title1') }}</h3>
    </div>
    <div class="container home-article home-article-one">
      <!-- <img src="../assets/images/knife.png" alt="" class="col-md-8 col-4"> -->
      <img src="../../assets/images/game.png" alt="">
      <p>{{ $t('index_article_text1') }}</p>
      <div class="home-article-text">
          {{ $t('article_text_part1') }}<br/>
          {{ $t('article_text_part2') }}<br/>
          <!-- {{ $t('article_text_part3') }}<br/>
          {{ $t('article_text_part4') }} -->
      </div>
    </div>
    <div class="container home-article">
      <img src="../../assets/images/gametwo.png" alt="">
      <p>{{ $t('article_text_lower1') }}<br> {{ $t('article_text_lower2') }}<br> {{ $t('article_text_lower3') }}
      </p>
    </div>
    <div class="container home-title home-title-two" @click.prevent="game_but">
      <h3>{{ $t('index_title2') }}</h3>
    </div>
    <div class="container kingdom">
      <div class="kingdom-start">
        <h2>all in</h2>
        <h2>or
          <span>x</span>
          <em>||</em>
        </h2>
        <h2>nothing</h2>
      </div>
      <div class="kingdom-brand">
        <p>
          {{$t('brand_word1')}}<br>
          <span>{{$t('brand_word2')}}</span> <br> 
          {{$t('brand_word3')}}<br> 
          {{$t('brand_word4')}}
          <span>{{$t('brand_word5')}}</span> <br> 
          {{$t('brand_word6')}}<br> 
          {{$t('brand_word7')}}<span>{{$t('brand_word8')}}</span>
        </p>
      </div>
    </div>
    <div class="container home-title home-title-two" @click.prevent="game_but">
      <h3>{{$t('index_title3')}}</h3>
    </div>
    <div class="container home-essay">
      <h1>{{$t('essay_title')}}</h1>
      <h3>{{$t('essay_title1')}}</h3>
      <p>{{$t('essay_word1')}}</p>
      <h3>{{$t('essay_title2')}}</h3>
      <p>{{$t('essay_word2')}}</p>
      <h3>{{$t('essay_title3')}}</h3>
      <p>{{$t('essay_word3')}}</p>
      <h3>{{$t('essay_title4')}}</h3>
      <p>{{$t('essay_word4')}}</p>
      <p class="essay-indent">
        <span>{{$t('essay_word_part1')}}</span><br>
        <span>{{$t('essay_word_part2')}}</span><br>
        <span>{{$t('essay_word_part3')}}</span><br>
        <span>{{$t('essay_word_part4')}}</span><br>
        <span>{{$t('essay_word_part5')}}</span><br>
        {{$t('essay_word_part6')}}<br>
        <span>{{$t('essay_word_part7')}}</span><br>
        <span>{{$t('essay_word_part8')}}</span><br>
        <span>{{$t('essay_word_part9')}}</span><br> 
        <span>{{$t('essay_word_part10')}}</span><br> 
        {{$t('essay_word_part11')}}<br>
        {{$t('essay_word_part12')}}
      </p>
      <h3>{{$t('essay_title5')}}</h3>
      <p>{{$t('essay_word5')}}</p>
      <h3>{{$t('essay_title6')}}</h3>
      <p>{{$t('essay_word6')}}<br>
         {{$t('essay_word7')}}
      </p>
      <p class="essay-indent">
        {{$t('essay_dan1')}}<br> 
        {{$t('essay_dan2')}}<br> 
        {{$t('essay_dan3')}}<br> 
        {{$t('essay_dan4')}}<br> 
        {{$t('essay_dan5')}}
      </p>
      <h3>{{$t('essay_title7')}}</h3>
      <p>{{$t('essay_word8')}}</p>
      <h3>{{$t('essay_title8')}}</h3>
    </div>
    <img v-if="btnFlag" class="go-top" src="../../assets/images/back.png" @click="backTop">
    <loading v-show="loadingShow"></loading>
  </div>
</template>

<script>
import loading from '../../components/loading'
// import {NETWORKS} from '../../utils/constants/networks'
// import {mapState} from 'vuex'
import Vue from "vue";
export default {
  components:{
    loading
  },
  name: "home",
  data () {
    return {
      btnFlag: false,
      loadingShow: true
    }
  },
  // computed: mapState({
  //   isInjected: state => state.web3.isInjected,
  //   network: state => NETWORKS[state.web3.networkId],
  //   coinbase: state => state.web3.coinbase,
  //   balance: state => state.web3.balance,
  //   ethBalance: state => {
  //     if (state.web3.web3Instance !== null) return state.web3.web3Instance().fromWei(state.web3.balance, 'ether')
  //   }
  // }),
  watch: {
    $route(to) {
      if (to.query.address) {
        localStorage.setItem("address", this.$route.query.address);
      }
    }
  },
  created() {
    if (this.$route.query.address) {
      localStorage.setItem("address", this.$route.query.address);
    }
    this.$nextTick(function () {
      setInterval(()=>{
        this.loadingShow= false
      },1000)
    })
  },
  mounted() {
    window.addEventListener("scroll", this.scrollToTop);
  },
  destroyed() {
    window.removeEventListener("scroll", this.scrollToTop);
  },
  methods: {
    backTop() {
      let that = this;
      let timer = setInterval(() => {
        let ispeed = Math.floor(-that.scrollTop / 5);
        document.documentElement.scrollTop = document.body.scrollTop =
          that.scrollTop + ispeed;
        if (that.scrollTop === 0) {
          clearInterval(timer);
        }
      }, 16);
    },
    scrollToTop() {
      let that = this;
      let scrollTop =
        window.pageYOffset ||
        document.documentElement.scrollTop ||
        document.body.scrollTop;
      that.scrollTop = scrollTop;
      if (that.scrollTop > 60) {
        that.btnFlag = true;
      } else {
        that.btnFlag = false;
      }
    },
    game_but () {
      if (window.web3) {
        if (!window.web3.eth.coinbase) {
            this.$store.dispatch('getinformation')
            this.$message({ type:'custom',message: this.$t('login') +  "metamask" })
        } else {
          localStorage.setItem("kingtoken", true); 
          this.$router.push({
            path: './game'
          })
        }
      } else {
        this.$message({ type:'custom',message:this.$t('installation') +  "metamask" })
      }
    },
    en_but() {
      Vue.config.lang  = 'en-US'
    },
    tw_but () {
      Vue.config.lang  = 'zh-TW'
    },
    sv_but () {
      Vue.config.lang  = 'sv-SE'
    }
  }
};
</script>
<style lang="scss" scoped>
.home {
  .language{
    position: fixed;
    top: 0;
    right: 0;
    left: 0;
    color: #fff;
    padding: 20px;
    text-align: right;
    span{
      margin-left: 20px;
      cursor: pointer;
    }
  }
  .go-top{
    position: fixed;
    right: 100px;
    bottom: 100px;
    width: 40px;
    cursor: pointer;
  }
  padding-bottom: 50px;
  background: #312d31;
  .home-title {
    width: 270px;
    height: 96px;
    margin-top: 81px;
    margin-bottom: 56px;
    background: url("../../assets/images/title-bj.png") center no-repeat;
    background-size: 100% 100%;
    cursor: pointer;
    h3 {
      font-size: 32px;
      text-align: center;
      line-height: 88px;
      font-family: SourceHanSansSC-Heavy;
      color: rgba(244, 235, 178, 1);
      text-shadow: 0px 1px 7px rgba(91, 51, 7, 1);
    }
  }
  .home-header {
    height: 100%;
    background: url("../../assets/images/header-bj.png") center no-repeat;
    background-size: 100% 100%;
    img {
      width: 100%;
      height: 100%;
      margin: 57px auto;
    }
  }
  .home-article {
    background: url("../../assets/images/game-bj.png") center no-repeat;
    background-size: 100% 100%;
    padding: 175px 158px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    img {
      width: 100%;
    }
    p {
      width: 100%;
      margin-top: 72px;
      // margin-bottom: 91px;
      font-size: 30px;
      color: #642d21;
      font-family: SourceHanSansSC-Regular;
      font-weight: 400;
      line-height: 68px;
      word-wrap:break-word;
    }
    .home-article-text {
      font-size: 36px;
      color: #b45d06;
      font-family: SourceHanSansSC-Bold;
      font-weight: bold;
      line-height: 68px;
    }
  }
  .home-article-one {
    margin-bottom: 42px;
  }
  .home-title-two {
    margin-top: 200px;
  }
  .kingdom {
    .kingdom-start {
      background: url("../../assets/images/start.png") center no-repeat;
      background-size: 100% 100%;
      padding: 153px 273px;
      h2 {
        font-size: 73px;
        font-family: adineuePRO-Bold;
        font-weight: bold;
        color: #ffffff;
        position: relative;
        em {
          font-style: normal;
          font-size: 50px;
          color: #ff0000;
          font-weight: 600;
          position: relative;
          top: -9px;
          margin-left: 60px;
        }
        span {
          position: absolute;
          top: -25px;
          left: 10px;
          color: #312d31;
          font-size: 109px;
          font-weight: 600;
        }
      }
    }
    .kingdom-brand {
      margin-top: 137px;
      background: url("../../assets/images/brand-bj.png") center no-repeat;
      background-size: 100% 100%;
      padding: 238px 142px;
      p {
        font-size: 30px;
        color: #642d21;
        font-family: SourceHanSansSC-Bold;
        font-weight: bold;
        line-height: 68px;
        span {
          color: #3147a9;
        }
      }
    }
  }
  .home-essay {
    background: url("../../assets/images/essay-bj.png") center no-repeat;
    background-size: 100% 100%;
    padding: 143px 100px;
    padding-bottom: 393px;
    h1 {
      font-size: 46px;
      color: #7c264a;
      text-align: center;
      font-family: STYuanti-TC-Regular;
      margin-bottom: 30px;
    }
    h3 {
      font-size: 28px;
      color: #642d21;
      font-weight: 600;
      font-family: SourceHanSansSC-Bold;
      margin-bottom: 46px;
      margin-top: 46px;
    }
    p {
      font-size: 22px;
      color: #642d21;
      line-height: 55px;
      // margin-bottom: 76px;
      text-indent: 45px;
      span {
        margin-left: 46px;
      }
    }
    .essay-indent{
      text-indent: 0px;
    }
  }
}
@media screen and (min-width: 0px) and (max-width: 768px) {
  .home {
    .go-top{
      position: fixed;
      right: 35px;
      bottom: 35px;
      width: 30px;
    }
    background: #312d31;
    .home-title {
      margin-top: 0px;
      margin-bottom: 36px;
      h3 {
        font-size: 24px;
      }
    }
    .home-header {
      img {
        width: 100%;
        height: 100%;
        margin: 57px auto;
      }
    }
    .home-article {
      padding: 55px 44px;
      img {
        width: 100%;
      }
      p {
        margin-top: 35px;
        font-size: 16px;
        line-height: 30px;
        margin-bottom: 14px;
      }
      .home-article-text {
        font-size: 16px;
        line-height: 30px;
      }
    }
    .home-article-one {
      margin-bottom: 32px;
    }
    .home-title-two {
      margin-top: 92px;
    }
    .kingdom {
      .kingdom-start {
        padding: 91px 80px;
        h2 {
          font-size: 44px;
          em {
            font-size: 30px;
            color: #ff0000;
            top: -9px;
            margin-left: 35px;
          }
          span {
            font-size: 60px;
            top: -10px;
            left: 8px;
          }
        }
      }
      .kingdom-brand {
        margin-top: 65px;
        padding: 93px 38px;
        p {
          font-size: 16px;
          line-height: 28px;
          span {
            color: #3147a9;
          }
        }
      }
    }
    .home-essay {
      padding: 60px 40px;
      padding-bottom: 54px;
      // background: url('../assets/images/mobile-essay-bj .png') center no-repeat;
      background-size: 100% 100%;
      h1 {
        font-size: 24px;
        margin-bottom: 0px;
      }
      h3 {
        font-size: 14px;
        margin-bottom: 18px;
        margin-top: 18px;
      }
      p {
        font-size: 14px;
        color: #642d21;
        line-height: 20px;
        margin-bottom: 14px;
        text-indent: 26px;
        span {
          margin-left: 6px;
        }
      }
    }
  }
}
</style>

