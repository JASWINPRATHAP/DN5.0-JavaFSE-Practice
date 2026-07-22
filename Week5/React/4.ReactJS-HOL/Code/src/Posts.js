import React, { Component } from 'react';
import Post from './Post';

class Posts extends Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
      error: null
    };
  }
  loadPosts() {
    fetch('https://jsonplaceholder.typicode.com/posts')
      .then(response => {
        if (!response.ok) {
          throw new Error('Failed to load posts');
        }
        return response.json();
      })
      .then(data => {
        const postsList = data.map(item => new Post(item.id, item.title, item.body));
        this.setState({ posts: postsList });
      })
      .catch(error => {
        this.setState({ error: error.message });
        this.componentDidCatch(error, { componentStack: '' });
      });
  }
  componentDidMount() {
    this.loadPosts();
  }
  componentDidCatch(error, info) {
    alert('An error occurred in component: ' + error.message);
  }
  render() {
    if (this.state.error) {
      return (
        <div>
          <h3>Error loading posts</h3>
          <p>{this.state.error}</p>
        </div>
      );
    }
    return (
      <div>
        <h2>Posts</h2>
        {this.state.posts.map(post => (
          <div key={post.id}>
            <h3>{post.title}</h3>
            <p>{post.body}</p>
          </div>
        ))}
      </div>
    );
  }
}

export default Posts;
