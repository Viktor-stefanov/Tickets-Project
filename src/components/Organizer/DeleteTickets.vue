<template>
  <span>Event ID</span>
  <input type="text" @input="loadCategories" v-model="eventID"/>
  <br />
  <select v-model="chosenCategoryId">
    <option v-for="(category, index) in categories" :key="index" :value="index">{{category.name}}</option>
  </select>
  <button type="submit" @click="deleteTickets"></button>
</template>

<script>
import {getCategories, deleteTickets} from "../../utils/contracts"

export default {
  data() {
    return {
      eventID: null,
      categories: [],
      chosenCategoryId: null,
    }
  },
  methods: {
    async loadCategories() {
      if (this.eventID) {
        const eventNum = parseInt(this.eventID);
        this.categories = await getCategories(eventNum);
      }
    },
    async deleteTickets() {
      if (this.chosenCategoryId && this.eventID) {
        const eventNum = parseInt(this.eventID);
        await deleteTickets(eventNum, this.eventID);
      }
    }
  }
}
</script>
