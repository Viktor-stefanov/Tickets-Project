<template>
  <span>Category name</span>
  <input type="text" id="name" />
  <br />
  <span>Category description</span>
  <input type="text" id="description" />
  <br />
  <span>Ticket price</span>
  <input type="number" id="price" />
  <br />
  <span>Maximal amount of tickets per account</span>
  <input type="number" id="maxTickets" />
  <br />
  <span>Ticket type</span>
  <select v-model="ticketType">
    <option :value="'Fungible'">Fungible (all tickets are priced the same)</option>
    <option :value="'Non-fungible'">Non Fungible (seats are enumerated and priced differenly)</option>
  </select>
  <div v-if="ticketType === 'Fungible'">
    <span>Amount of tickets</span>
    <input type="number" id="ticketAmount">
  </div>
  <div v-else-if="ticketType === 'Non-fungible'">
    <span>Starting seat number</span>
    <input type="number" id="startNum">
    <br />
    <span>Ending seat number</span>
    <input type="number" id="endNum">
  </div>
  <br />
  <span>Start date:</span>
  <input type="datetime-local" id="startDate" />
  <br />
  <span>End date:</span>
  <input type="datetime-local" id="endDate" />
  <br />
  <span>Ticket discounts (optional)</span>
  <br />
  <input type="checkbox" id="2-1" name="2-1">
  <label for="2-1">2 tickets for 1</label><br />
  <input type="checkbox" id="3-2" name="3-2">3 tickets for 2
  <label for="3-2">3 tickets for 2</label><br />
  <input type="checkbox" id="4-3" name="4-3">4 tickets for 3
  <label for="4-3">4 tickets for 3</label><br />
  <button type="submit" @click="addCategory()">Add ticket category</button>
</template>

<script>
import { addTicketCategory } from "../utils/contracts";

export default {
  data() {
    return {
      ticketType: "",
    }
  },
  methods: {
    getCategoryData() {
      const categoryData = {
        name: document.getElementById("name")?.value,
        description: document.getElementById("description")?.value,
        price: document.getElementById("price")?.value,
        maxTickets: document.getElementById("maxTickets")?.value,
        ticketType: this.ticketType,
        startDate: document.getElementById("startDate")?.value,
        endDate: document.getElementById("endDate")?.value,
        ticketConfig: this.ticketType === 'Fungible' ? 
                                      [document.getElementById("ticketAmount").value] :
                                      [document.getElementById("startNum").value, document.getElementById("endNum")],
        ticketDiscounts: [document.getElementById("2-1").checked,
                          document.getElementById("3-2").checked,
                          document.getElementById("4-3").checked],
      };
      if (Object.values(categoryData).some((el) => {return el === ""}) || categoryData.ticketConfig[0] === "") {
        return null;
      } else {
        categoryData.startDate = new Date(categoryData.startDate).getTime();
        categoryData.endDate = new Date(categoryData.endDate).getTime();
        categoryData.ticketConfig = categoryData.ticketConfig.map((el) => {return parseInt(el)});
        return categoryData;
      }
    },
    async addCategory() {
      const ticketCategory = this.getCategoryData();
      if (ticketCategory) {
        if (await addTicketCategory(ticketCategory, 1)) {
          console.log("successful");
        }
      }
    }
  }
}
</script>
