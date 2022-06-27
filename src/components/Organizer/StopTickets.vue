<template>
  <span>Event ID</span>
  <input type="text" v-model="eventID"/>
  <br />
  <select @change="loadCategories($event)">
    <option :value="'All'">Stop all tickets</option>
    <option :value="'Category'">Stop tickets from a certain category</option>
  </select>
  <br />
  <select v-model="chosenCategoryID" v-if="categories.length > 0">
    <option v-for="(category, index) in categories" :key="index" :value="category.id">{{category.name}}</option>
  </select>
  <button type="submit" @click="stopTickets()">Stop tickets</button>
</template>

<script>
import {getCategories, stopCategory, stopTickets} from "../../utils/contracts";

export default {
  data() {
    return {
      eventID: null,
      categories: [],
      chosenCategoryID: null,
    }
  },
  methods: {
    async loadCategories(event) {
      const eventNum = parseInt(this.eventID);
      if (event.target.value === "Category" && eventNum) {
        this.categories = await getCategories(eventNum);
      }
    },
    async stopTickets() {
      const eventNum = parseInt(this.eventID);
      if (this.chosenCategoryID) {
        await stopCategory(eventNum, this.chosenCategoryID);
      } else {
        await stopTickets(eventNum);
      }
    }
  },
}
</script>
