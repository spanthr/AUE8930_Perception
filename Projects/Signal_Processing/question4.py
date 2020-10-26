import matplotlib.pyplot as plt
from nuscenes.nuscenes import NuScenes

nusc = NuScenes(version='v1.0-mini', dataroot=r'C:\Users\shaur\OneDrive\Desktop\SPRING 2020\Courses\AUE Perception\Assignment\v1.0-mini', verbose=True)

sensor='RADAR_FRONT_RIGHT'
# plt.figure()
for i in range(5):
    my_sample = nusc.sample[i]

    nusc.render_pointcloud_in_image(my_sample['token'], pointsensor_channel=sensor)
    #nusc.render_sample_data(my_sample['data']['RADAR_FRONT'], nsweeps=5, underlay_map=True)
    #radar_front_data=nusc.get('sample_data',['radar_front_data'])
    #print(radar_front_data)
    plt.title('Nuscenes data for the frame'+str(i+1))
plt.show()


sensor='RADAR_FRONT'
# plt.figure()
for i in range(5):
    my_sample = nusc.sample[i]

    nusc.render_pointcloud_in_image(my_sample['token'], pointsensor_channel=sensor)
    #nusc.render_sample_data(my_sample['data']['RADAR_FRONT'], nsweeps=5, underlay_map=True)
    #radar_front_data=nusc.get('sample_data',['radar_front_data'])
    #print(radar_front_data)
    plt.title('Nuscenes data for the frame'+str(i+1))
plt.show()

my_sample = nusc.sample[10]
my_scene_token = nusc.field2token('scene', 'name', 'scene-0061')
my_scene_token = nusc.field2token('scene', 'name', 'scene-0061')[0]
nusc.render_scene_channel(my_scene_token, 'CAM_FRONT')

nusc.render_sample_data(my_sample['data']['CAM_FRONT'])
plt.show()
