<template>
  <div v-for="(event, index) in events" :key="index" :id="index">
    <p>Event name: {{event.name}}</p>
    <p>Code: {{event.ID}}</p>
    <p>Website: {{event.websiteUrl}}</p>
    <p>Location: {{event.location}}</p>
    <p>Poster: {{event.posterUrl}}</p>
    <p>Start date: {{event.startDate}}</p>
    <p>End date: {{event.endDate}}</p>
    <select v-bind="selectedCategoryId">
      <option v-for="(category, idx) in event.categories" :key="idx" :value="idx">{{category.name}}</option>
    </select>
    <div v-if="selectedCategoryId">
      <p>Name: {{event.categories[selectedCategoryId].name}}</p>
      <p>Description: {{event.categories[selectedCategoryId].description}}</p>
      <p>Ticket type: {{event.categories[selectedCategoryId].ticketType}}</p>
      <p>Ticket price: {{event.categories[selectedCategoryId].ticketPrice}}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      selectedCategoryId: null,
    }
  },
  methods: {
  },
  props: {events: Array}
}
</script>

<style scoped>
  div {
    display: inline;
    margin: 10px;
  }
</style>
