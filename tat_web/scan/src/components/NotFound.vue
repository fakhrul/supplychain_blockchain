<template>
  <div class="hello">
    <h1>{{productId}}</h1>
   <Timeline
    :timeline-items="timelineItems"
    :message-when-no-items="messageWhenNoItems"/>
  </div>
</template>

<script>
import Timeline from 'timeline-vuejs'
export default {
  name: 'NotFound',
     components: {
      Timeline
    },
  props: {
    msg: String
  },
   data: () => ({
     productId: "",
    messageWhenNoItems: 'There are not items',
    timelineItems: [
      {
        from: new Date(2018, 7,2),
        showDayAndMonth: true,
        title: 'Name',
        color: '#e74c3c',
        description:
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
      },
      {
        from: new Date(2016, 1,20),
        showDayAndMonth: true,
        title: 'Name',
        color: '#2ecc71',
                description:
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
      },
      {
        from: new Date(2016, 6,15),
        showDayAndMonth: true,
        color: '#e74c3c',
        title: 'Name',
        description:
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
      },
      {
        from: new Date(2012, 0,2),
        showDayAndMonth: true,
        color: '#2ecc71',
                title: 'Name',
        description:
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
      }
    ]
  }),
    mounted() {
    var self = this;
      alert(self.$route.params.id);
    if (self.$route.params.id) {
      self.productId =self.$route.params.id;
      // this.api.getArea(self.$route.params.id).then((response) => {
      //   self.obj = response.data;
      // });
    }
  },

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
