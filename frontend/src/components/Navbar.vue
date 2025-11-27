<template>
    <div class="">
        <section class="py-10 bg-gray-100">
            <!-- logo and nav-menu -->
            <div class="container px-4 mx-auto flex items-center justify-between">
                <!-- logo -->
                <div class="">
                    <img src="/school.png" alt="school" width="40">
                </div>

                <!-- desktop menu -->
                <div class="hidden md:flex items-center justify-between gap-4 text-lg font-bold">
                    <a href="#">Home</a>
                    <a href="#">About</a>
                    <a href="#">Contact</a>
                </div>

                <!-- mobile menu button -->
                 <button @click="mobileButton" class="block md:hidden">
                    <img src="/more.png" alt="more" width="40">
                 </button>
            </div>

            <!-- m menu -->
             <div v-if="isMobile" class="md:hidden bg-white p-4 shadow-lg">
                <div class="flex flex-col space-y-3">
                    <a href="#" class="block py-2 hover:text-blue-600">Home</a>
                    <a href="#" class="block py-2 hover:text-blue-600">About</a>
                    <a href="#" class="block py-2 hover:text-blue-600">Contact</a>
                </div>
             </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            isMobile: false
        }
    },

    methods: {
        mobileButton() {
            this.isMobile = !this.isMobile
        }
    }
}
</script>
