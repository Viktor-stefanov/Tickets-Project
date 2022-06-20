<template>
  <button type="submit" v-if="!createEventInput" @click="createEventInput = true">Create event</button>
  <div v-if="createEventInput">
    <CreateEventInput />
    <button type="submit" @click="createEvent()">Publish event</button>
  </div>
</template>

<script>
import CreateEventInput from "./CreateEvent.vue"
import { createEvent } from "../utils/contracts";

export default {
  data() {
    return {
      createEventInput: false,
    }
  },
  methods: {
    getEventData() {
      const eventData = {
        name : document.getElementById("name")?.value,
        websiteUrl : document.getElementById("websiteUrl")?.value,
        posterUrl : document.getElementById("posterUrl")?.value,
        startDate : document.getElementById("startDate")?.value,
        endDate : document.getElementById("endDate")?.value,
        country : document.getElementById("country")?.value,
        city : document.getElementById("city")?.value,
        address : document.getElementById("address")?.value,
      }
      return Object.values(eventData).some((el) => {return el === ""}) ? null : eventData;
    },
    async createEvent() {
      createEvent({});
      const event = this.getEventData();
      if (event) {
        createEvent(event); 
      }
    }
  },
  components: {CreateEventInput}
}
</script>
