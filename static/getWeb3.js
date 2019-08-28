import Web3 from 'web3'

let getWeb3 = new Promise(function (resolve, reject) {
    var web3js = window.web3
    if (typeof web3js !== 'undefined') {
      var web3 = new Web3(web3js.currentProvider)

      window.console.log(web3, 'web3')
      web3.eth.defaultAccount=web3.eth.coinbase;
      // window.console.log(web3.eth, 'eth.defaultAccount=eth.coinbase;')
      // window.console.log(this.$store.state.web3.coinbase)

      resolve({
        injectedWeb3: web3.isConnected(),
        web3() {
          return web3
        }
      })
    } else {
      reject(new Error('Unable to connect to Metamask'))
    }
  })
  .then(result => {
    return new Promise(function (resolve, reject) {
      // Retrieve network ID
      result.web3().version.getNetwork((err, networkId) => {
        if (err) {
          // If we can't find a networkId keep result the same and reject the promise
          reject(new Error('Unable to retrieve network ID'))
        } else {
          // Assign the networkId property to our result and resolve promise
          result = Object.assign({}, result, {
            networkId
          })
          resolve(result)
        }
      })
    })
  })
  .then(result => {
    return new Promise(function (resolve, reject) {
      // Retrieve coinbase
      result.web3().eth.getCoinbase((err, coinbase) => {
        if (err) {
          reject(new Error('Unable to retrieve coinbase'))
        } else {
          result = Object.assign({}, result, {
            coinbase
          })
          resolve(result)
        }
      })
    })
  })
  .then(result => {
    return new Promise(function (resolve, reject) {
      // Retrieve balance for coinbase
      result.web3().eth.getBalance(result.coinbase, (err, balance) => {
        if (err) {
          reject(new Error('Unable to retrieve balance for address: ' + result.coinbase))
        } else {
          result = Object.assign({}, result, {
            balance
          })
          resolve(result)
        }
      })
    })
  })

export default getWeb3