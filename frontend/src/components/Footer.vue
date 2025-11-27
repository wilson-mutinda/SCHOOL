<template>
    <div class="">
        <section class="bg-gray-800 text-white py-12">
            <!-- logo, quick links, contacts, follows us -->
            <div class="container px-4 mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
                <!-- logo & description -->
                <div class="space-y-4">
                    <div class="flex items-center gap-3">
                        <img src="/school.png" alt="logo" width="40">
                        <span class="text-xl font-bold">SchoolApp</span>
                    </div>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        Siplifying and automating.
                    </p>
                </div>

                <!-- quick links -->
                <div class="">
                    <h3 class="font-bold mb-4 text-lg">Quick Links</h3>
                    <div class="flex flex-col space-y-2">
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition duration-300">Home</a>
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition duration-300">About</a>
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition duration-300">Programs</a>
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition duration-300">Contact</a>
                    </div>
                </div>

                <!-- Contacts -->
                <div class="space-y-4">
                    <h3 class="font-bold mb-4 text-lg">Contacts</h3>

                    <!-- address -->
                    <div class="flex gap-3 items-start">
                        <img src="/map-pin-house.png" alt="address" width="20" class="mt-1">
                        <span class="text-gray-300 text-sm">Blue Violets Plaza,<br>Kindaruma Road, Nairobi</span>
                    </div>

                    <!-- phone -->
                    <div class="flex gap-3 items-center">
                        <img src="/phone-solid-full.svg" alt="phone" width="20">
                        <span class="text-gray-300 text-sm">+254 791 738 418</span>
                    </div>

                    <!-- email -->
                    <div class="flex gap-3 items-center">
                        <img src="/envelope-solid-full.svg" alt="email" width="20">
                        <span class="text-gray-300 text-sm">mutidawilz@gmail.com</span>
                    </div>
                </div>

                <!-- follow us -->
                <div class="">
                    <h4 class="font-bold mb-4 text-lg">Follow Us</h4>
                    <div class="flex gap-4">
                        <!-- social icons -->
                        <a href="#" class="bg-gray-700 p-2 rounded-lg hover:bg-yellow-500 transition duration-300">
                            <img src="/facebook.png" alt="fb" width="20">
                        </a>
                        <a href="#" class="bg-gray-700 p-2 rounded-lg hover:bg-yellow-500 transition duration-300">
                            <img src="/twitter.png" alt="twitter" width="20">
                        </a>
                        <a href="#" class="bg-gray-700 p-2 rounded-lg hover:bg-yellow-500 transition duration-300">
                            <img src="/linkedin.png" alt="linkedin" width="20">
                        </a>
                        <a href="#" class="bg-gray-700 p-2 rounded-lg hover:bg-yellow-500 transition duration-300">
                            <img src="/instagram.png" alt="instagram" width="20">
                        </a>
                    </div>
                </div>
            </div>

            <!-- copyright section -->
            <div class="border-t border-gray-700 pt-6">
                <div class="container px-4 mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
                    <!-- copyright text -->
                    <div class="flex items-center gap-2 text-gray-300 text-sm">
                        <img src="/copyright.png" alt="copyright" width="14">
                        <span>{{ currentYear }} mungedevs.com. All rights reserved.</span>
                    </div>
                    
                    <!-- additional links -->
                    <div class="flex gap-6 text-sm">
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition">Privacy Policy</a>
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition">Terms of Service</a>
                        <a href="#" class="text-gray-300 hover:text-yellow-400 transition">Sitemap</a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    name: 'FooterSection',
    data() {
        return {
            currentYear: new Date().getFullYear()
        }
    }
}
</script>