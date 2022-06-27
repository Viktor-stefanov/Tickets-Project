 <template>
  <span>Event name:</span>
  <input type="text" id="name" />
  <br />
  <span>Event's website URL:</span>
  <input type="text" id="websiteUrl" />
  <br />
  <span>Start date:</span>
  <input type="datetime-local" id="startDate" />
  <br />
  <span>End date:</span>
  <input type="datetime-local" id="endDate" />
  <br />
  <span>Event location (country):</span>
  <input type="text" id="country" />
  <br />
  <span>Event location (city):</span>
  <input type="text" id="city" />
  <br />
  <span>Event location (address):</span>
  <input type="text" id="address" />
  <br />
  <span>URL to official poster:</span>
  <input type="text" id="posterUrl" />
  <br />
  <button type="submit" @click="createEvent()">Publish event</button>
</template>

<script>
import { publishEvent } from "../../utils/contracts";

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
        if (Object.values(eventData).some((el) => {return el === ""})) {
          console.log(eventData);
          return null;
        } else {
          eventData.startDate = new Date(eventData.startDate).getTime();
          eventData.endDate = new Date(eventData.endDate).getTime();
          return eventData;
        }
      },
      async createEvent() {
        const event = this.getEventData();
        if (event) {
          if (await publishEvent(event)) {
            this.$emit("eventPublished");
          }; 
        }
      }
    },
    emits: ["eventPublished"],
}
</script>
