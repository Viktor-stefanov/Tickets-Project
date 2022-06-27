<template>
  <span>Event ID</span>
  <input type="text" v-model="eventID"/>
  <br />
  <select @change="loadCategories($event)">
    <option :value="'All'">Sell all tickets</option>
    <option :value="'Category'">Sell tickets from a certain category</option>
  </select>
  <br />
  <select v-model="chosenCategoryId" v-if="categories.length > 0">
    <option v-for="(category, index) in categories" :key="index" :value="category.id">{{category.name}}</option>
  </select>
  <button type="submit" @click="sellTickets()">Stop tickets</button>
</template>

<script>
import {getCategories, sellCategoryTickets, sellTickets} from "../../utils/contracts"

export default {
  data() {
    return {
      eventID: null,
      chosenCategoryId: null,
      categories: [],
    }
  },
  methods: {
    async loadCategories(event) {
      const eventNum = parseInt(this.eventID);
      if (event.target.value === "Category" && eventNum) {
        this.categories = await getCategories(eventNum);
      }
    },
    async sellTickets() {
      const eventNum = parseInt(this.eventID);
      if (this.chosenCategoryID) {
        await sellCategoryTickets(eventNum, this.chosenCategoryID);
      } else {
        await sellTickets(eventNum);
      }
    }
  }
}
</script>
