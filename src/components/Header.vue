<template>
  <button type="submit" @click="displayPage = 'Organize'">Organize event</button>
  <button type="submit" @click="displayPage = 'Browse'">Browse events</button>
  <h4>Account: {{accountAddress}}</h4>
  <br />
  <Browse v-if="displayPage === 'Browse'" />
  <Organize v-if="displayPage === 'Organize'" />
  <!--<Test />-->
</template>

<script>
import Browse from "./Browser/BrowseEvents.vue"
import Organize from "./Organizer/Organize.vue"
import Test from "./Organizer/test.vue";

export default {
  data() {
    return {
      displayPage: "",
    }
  },
  props: {
    accountAddress: String,
  },
  components: {Browse, Organize, Test}
}
</script>

<style scoped>
  h4 {
    display: inline;
  }
  button {
    margin: 0 15px 15px 0;
  }
</style>
