<script setup lang="ts">
import Navbar from '@/components/Navbar.vue';
import Footer from '@/components/Footer.vue';

</script>

<template>
    <div class="bg-gray-50 min-h-screen">
        <!-- left section and right section -->
         <div class="flex p-4 flex-col md:flex-row gap-1">
            <!-- left section -->
             <div class="md:w-64 w-full min-h-screen bg-blue-100 rounded-md p-4">
                <!-- logo / header -->
                 <div class="mb-8 p-4 border-b border-blue-300">
                    <!-- logo -->
                     <div class="flex items-center gap-3">
                        <img src="/school.png" alt="logo" width="20">
                        <span>Student Portal</span>
                     </div>
                 </div>

                 <!-- Navigation Menu -->
                  <nav class="space-y-3">

                    <!-- Dashboard -->
                     <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                        <img src="/dashboard.png" alt="dashboard" width="20">
                        <span class="text-white font-bold">Dashboard</span>
                     </a>

                     <!-- my courses -->
                      <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                        <img src="/curriculum.png" alt="courses" width="20">
                        <span class="text-white font-bold">My Courses</span>
                      </a>

                      <!-- Assignments -->
                       <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                        <img src="/assignment.png" alt="assignments" width="20">
                        <span class="text-white font-bold">Assignments</span>
                       </a>

                       <!-- Grades -->
                        <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                            <img src="/grade.png" alt="grades" width="20">
                            <span class="text-white font-bold">Grades</span>
                        </a>

                        <!-- Schedule -->
                         <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                            <img src="/schedule.png" alt="schedule" width="20">
                            <span class="text-white font-bold">Schedule</span>
                         </a>

                         <!-- resources -->
                          <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                            <img src="/resources.png" alt="resources" width="20">
                            <span class="text-white font-bold">Learning Resources</span>
                          </a>

                          <!-- Messages -->
                           <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                            <img src="/message.png" alt="messages" width="20">
                            <span class="text-white font-bold">Messages</span>
                            <span class="ml-auto bg-green-500 text-white text-xs px-2 py-1 rounded-full">5</span>
                           </a>

                           <!-- Profile -->
                            <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                                <img src="/profile.png" alt="profile" width="20">
                                <span class="text-white font-bold">My Profile</span>
                            </a>

                            <!-- Settings -->
                             <a href="#" class="flex items-center gap-3 p-3 rounded-lg bg-blue-400 hover:bg-blue-700 transition">
                                <img src="/settings.png" alt="settings" width="20">
                                <span class="text-white font-bold">Settings</span>
                             </a>
                  </nav>
             </div>
             <!-- right section -->
              <div class="flex-1">

                <!-- NAvbar -->
                 <div class="bg-white shadow-sm border-b">
                    <Navbar/>
                 </div>

                <!-- Dashboard Content -->
                 <main class="p-6">

                    <!-- welcome section -->
                    <div class="mb-6">
                        <h2 class="text-2xl font-bold text-gray-800">Welcome back, John!</h2>
                        <p class="text-gray-600">Here's your learning overview for today</p>
                    </div>

                    <!-- stats cards -->
                     <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">

                        <!-- active courses -->
                         <div class="bg-white p-4 rounded-lg shadow border">
                            <h3 class="font-semibold text-gray-600">Active Courses</h3>
                            <p class="text-2xl font-bold text-blue-600">4</p>
                         </div>

                         <!-- Assignments -->
                          <div class="bg-white p-4 rounded-lg shadow border">
                            <h3 class="font-semibold text-gray-600">Assignments Due</h3>
                            <p class="text-2xl font-bold text-blue-600">3</p>
                          </div>

                          <!-- Completed -->
                           <div class="bg-white p-4 rounded-lg shadow border">
                             <h3 class="font-semibold text-gray-600">Completed</h3>
                             <p class="text-2xl font-bold text-blue-600">12</p>
                           </div>

                           <!-- Attendance -->
                            <div class="bg-white p-4 rounded-lg shadow border">
                                <h3 class="font-semibold text-gray-600">Attendance</h3>
                                <p class="text-2xl font-bold text-blue-600">95%</p>
                            </div>
                     </div>

                     <!-- Recent Activity aand upcoming classes -->
                      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <!-- Recent Activity -->
                        <div class="bg-white p-6 rounded-lg shadow border">
                            <h3 class="text-lg font-semibold mb-4">Recent Activity</h3>
                            <div class="space-y-3">
                                <div class="flex items-center gap-3 p-3 bg-blue-50 rounded">
                                    <div class="w-2 h-2 bg-blue-500 rounded-full"></div>
                                    <span>Submitted Web Development assignment</span>
                                    <span class="text-sm text-gray-500 ml-auto">2h ago</span>
                                </div>
                                <div class="flex items-center gap-3 p-3 bg-green-50 rounded">
                                    <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                                    <span>Completed Cybersecurity quiz</span>
                                    <span class="text-sm text-gray-500 ml-auto">1d ago</span>
                                </div>
                            </div>
                        </div>

                        <!-- Upcoming classes -->
                         <div class="bg-white p-6 rounded-lg shadow border">
                            <h3 class="text-lg font-semibold mb-4">Today's Schedule</h3>
                            <div class="space-y-3">

                                <div class="flex justify-between items-center p-3 border rounded">
                                    <div class="">
                                        <p class="font-semibold">Web Development</p>
                                        <p class="text-sm text-gray-600">10:00 AM - 11:30 AM</p>
                                    </div>
                                    <span class="bg-blue-100 text-blue-800 px-2 py-1 rounded text-sm">Room 302</span>
                                </div>

                                <div class="flex justify-between items-center p-3 border rounded">
                                    <div class="">
                                        <p class="font-semibold">Data Science</p>
                                        <p class="text-sm text-gray-600">2:00 PM - 3:30 PM</p>
                                    </div>
                                    <span class="bg-green-100 text-green-800 px-2 py-1 rounded text-sm">Lab A</span>
                                </div>
                            </div>
                         </div>
                      </div>
                 </main>
              </div>
         </div>

         <!-- footer -->
          <div class="">
            <Footer/>
          </div>
    </div>
</template>