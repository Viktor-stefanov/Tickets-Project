<template>
  <button type="submit" v-if="input !== 'Create Event'" @click="input = 'Create Event'">Create event</button>
  <button type="submit" v-if="input !== 'Add Category'" @click="input = 'Add Category'">Add ticket category</button>
  <button type="submit" v-if="input !== 'Stop Tickets'" @click="input = 'Stop Tickets'">Stop tickets</button>
  <button type="submit" v-if="input !== 'Sell Tickets'" @click="input = 'Sell Tickets'">Sell tickets</button>
  <button type="submit" v-if="input !== 'Delete Tickets'" @click="input = 'Delete Tickets'">Delete tickets</button>
  <br />
  <PublishEvent @eventPublished="createEventInput=false" v-if="input === 'Create Event'"/>
  <AddCategory v-if="input === 'Add Category'" />
  <SellTickets v-if="input === 'Sell Tickets'" />
  <StopTickets v-if="input === 'Stop Tickets'" />
  <DeleteTickets v-if="input === 'Delete Tickets'" />
</template>

<script>
import PublishEvent from "./PublishEvent.vue"
import AddCategory from "./AddCategory.vue"
import StopTickets from "./StopTickets.vue"
import SellTickets from "./SellTickets.vue"
import DeleteTickets from "./DeleteTickets.vue"

export default {
  data() {
    return {
      input: "",      
    }
  },
  methods: {

  },
  components: {PublishEvent, AddCategory, StopTickets, SellTickets, DeleteTickets},
}
</script>
