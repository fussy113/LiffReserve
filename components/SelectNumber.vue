<template>
  <v-row fluid>
    <v-col cols="12">
      <v-radio-group :label="selectLiffLine.label" @change="updateChoice">
        <v-radio
          v-for="n in selectLiffLine.selects"
          :key="n.id"
          :label="`${n.label}`"
          :value="n.id"
        />
      </v-radio-group>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    selectLiffLine: {
      type: Object,
      default: () => {}
    }
  },
  methods: {
    updateChoice(e) {
      this.$emit('input', e)
    }
  }
}
</script>
