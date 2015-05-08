/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  DeviceEventEmitter,
} = React;

var CoinbaseApi = require('NativeModules').CoinbaseApi;

var CoinbaseExample = React.createClass({
  componentWillMount: function() {
    DeviceEventEmitter.addListener('CoinbaseOAuthComplete', function(result) {
      console.log(result);
    });
  },

  signIn: function() {
    var { clientId, clientSecret } = require('./ApiCredentials');
    CoinbaseApi.startAuthentication(clientId, clientSecret);
  },

  render: function() {
    return (
      <View style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <TouchableHighlight onPress={this.signIn}>
          <View style={{padding: 10, backgroundColor: '#cccccc'}}>
            <Text style={{fontSize: 15}}>Sign in to Coinbase</Text>
          </View>
        </TouchableHighlight>
      </View>
    );
  }
});

AppRegistry.registerComponent('CoinbaseExample', () => CoinbaseExample);
