<template>
  <div class="hello">
    <h1>{{ product.name }} - {{ product.id }}</h1>
    <Timeline
      :timeline-items="timelineItems"
      :message-when-no-items="messageWhenNoItems"
    />
  </div>
</template>

<script>
import Timeline from "timeline-vuejs";
import TatApi from "../lib/tatapi";

export default {
  name: "Scan",
  components: {
    Timeline,
  },
  props: {
    msg: String,
  },
  // data: () => ({
  //   productId: "",
  //   product: {},
  //   productTrail: [],
  //   messageWhenNoItems: "There are not items",
  //   timelineItems: [],
  //   api: new TatApi(),
  // }),
  data() {
    return {
      api: new TatApi(),
      product: {},
      productTrail: [],
      messageWhenNoItems: "There are not items",
      timelineItems: [],
    };
  },
  mounted() {
    var self = this;
    self.refreshTimeline();

  },
  methods: {
    refreshTimeline() {
      var self = this;
      if (self.$route.params.id) {
        self.api.getProduct(self.$route.params.id).then((response) => {
          self.product = response.data;
          this.api.getProductTrail(self.$route.params.id).then((response) => {
            self.productTrail = response.data.trailInfoList;
            for (var i = self.productTrail.length - 1; i >=0 ; i--) {
              var pointColor = i % 2 == 0 ? "#e74c3c" : "#2ecc71";

              var detailInfo =
                "<h4>" + self.productTrail[i].organization.name + "</h4>";
              detailInfo +=
                "<p>Area: " + self.productTrail[i].area.name + "</p>";
              detailInfo +=
                "<p>Activity: " + self.productTrail[i].activity.name + "</p>";
              detailInfo += "<p>GPS: " + self.productTrail[i].gps + "</p>";
              var info = {
                from: new Date(self.productTrail[i].createdDate * 1000),
                showDayAndMonth: true,
                title: self.productTrail[i].createdDateInText,
                color: pointColor,
                description: detailInfo,
              };
              self.timelineItems.push(info);
            }
          });
        });
      }
    },
  },
};
</script>
