<template>
  <input type="checkbox" @click="filters.upcoming = !filters.passed"><span>Upcoming events</span><br />
  <input type="checkbox" @click="filters.passed = !filters.passed"><span>Passed events</span><br />
  <button type="submit" @click="browse">Show events</button>
  <DisplayEvents :events="events"/>

</template>

<script>
import {getCategories, getEvents} from "../../utils/contracts"
import DisplayEvents from "./DisplayEvents.vue"

export default {
  data() {
    return {
      events: [],
      filters: {
        upcoming: false,
        passed: false,
        byUser: null,
      },
    }
  },
  methods: {
    async browse() {
      if (this.filters) {
        this.events = await getEvents(this.filters.upcoming, this.filters.passed);
        for (let event of this.events) {
          const eventNum = parseInt(event.ID);
          event.startDate = new Date(parseInt(event.startDate));
          event.endDate = new Date(parseInt(event.endDate));
          event.categories = await getCategories(eventNum);
        }
      }
    }
  },
  components: {DisplayEvents},
}
</script>
