<template>
  <div v-if="hasMetamask === false">
    <h1>Welcome to TicketBlock!</h1>
    <button type="submit" @click="loginUser()">Connect MetaMask</button>
  </div>
  <div v-else>
    <!-- add other components here -->
    <Header :accountAddress="accounts[0]"/>
  </div>
</template>

<script>
import {connectMetamask, hasMetamask} from "../utils/metamask"
import Header from "./Header.vue"

export default {
  data() {
    return {
      hasMetamask: false,
      metamaskConnected: false,
      accounts:  [],
    }
  },
  methods: {
    async loginUser() {
      this.hasMetamask = hasMetamask(); 
      if (this.hasMetamask) {
        this.accounts = await connectMetamask();
        this.metamaskConnected = true;
      }
    }
  },
  components: {
    Header
  }
}
</script>
