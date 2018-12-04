################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

CPP_SRCS += \
../src/chu_init.cpp \
../src/gpio_cores.cpp \
../src/main_vanilla_test.cpp \
../src/sseg_core.cpp \
../src/timer_core.cpp \
../src/uart_core.cpp 

OBJS += \
./src/chu_init.o \
./src/gpio_cores.o \
./src/main_vanilla_test.o \
./src/sseg_core.o \
./src/timer_core.o \
./src/uart_core.o 

CPP_DEPS += \
./src/chu_init.d \
./src/gpio_cores.d \
./src/main_vanilla_test.d \
./src/sseg_core.d \
./src/timer_core.d \
./src/uart_core.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze g++ compiler'
	mb-g++ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../sseg_bsp/microblaze_I/include -mno-xl-reorder -mlittle-endian -mcpu=v10.0 -mxl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


